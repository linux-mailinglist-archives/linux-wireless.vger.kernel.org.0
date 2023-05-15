Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA0702C45
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 14:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbjEOMGu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbjEOMGs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 08:06:48 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278FC9F;
        Mon, 15 May 2023 05:06:43 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1684152401; bh=11mN6KwHnU+nOjLMlBpTrvV6bBZGc90xuhb9aHHS4oM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qLyJrHEYphSeue9ryLSD6sSWroEyctS+WierSwPu21axPqsAik2gdEwSVpEazNpYE
         adwu8mv2FpEPZKkJJ+3bXa222vDwIMSr8kw0IouLvE8Tt8cFw2gaBgwPm+JtY4z6bT
         lgSAlysa/g0sVywYFHQqolO/tbLnuxNtM383m1Pcju6Q8o4sZhSJGxxaZ6aJTSOJMb
         EfsTzXEmGWp3LdiizOXV0Bk54uz+HjX++2/jsfS8P2pIRAHlLZZCcs4n3Lj59BTggj
         EHSooBKpDVY4AdamA0pbLz6l6jpA+Iz4PKtS+SUE/WWXfU6ynS9DlqeXFIdNyLs8Z+
         ROcrwLW9dAlTA==
To:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Hillf Danton <hdanton@sina.com>
Cc:     Kalle Vallo <kvalo@kernel.org>,
        syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v3 1/2] wifi: ath9k: fix races between ath9k_wmi_cmd and
 ath9k_wmi_ctrl_rx
In-Reply-To: <20230426190206.ni2au5mpjc5oty67@fpc>
References: <20230425192607.18015-1-pchelkin@ispras.ru>
 <20230425230708.2132-1-hdanton@sina.com>
 <20230426190206.ni2au5mpjc5oty67@fpc>
Date:   Mon, 15 May 2023 14:06:38 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ttwddcj5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fedor Pchelkin <pchelkin@ispras.ru> writes:

> On Wed, Apr 26, 2023 at 07:07:08AM +0800, Hillf Danton wrote: 
>> Given similar wait timeout[1], just taking lock on the waiter side is not
>> enough wrt fixing the race, because in case job done on the waker side,
>> waiter needs to wait again after timeout.
>> 
>
> As I understand you correctly, you mean the case when a timeout occurs
> during ath9k_wmi_ctrl_rx() callback execution. I suppose if a timeout has
> occurred on a waiter's side, it should return immediately and doesn't have
> to care in which state the callback has been at that moment.
>
> AFAICS, this is controlled properly with taking a wmi_lock on waiter and
> waker sides, and there is no data corruption.
>
> If a callback has not managed to do its work entirely (performing a
> completion and subsequently waking waiting thread is included here), then,
> well, it is considered a timeout, in my opinion.
>
> Your suggestion makes a wmi_cmd call to give a little more chance for the
> belated callback to complete (although timeout has actually expired). That
> is probably good, but increasing a timeout value makes that job, too. I
> don't think it makes any sense on real hardware.
>
> Or do you mean there is data corruption that is properly fixed with your
> patch?
>
> That is, I agree there can be a situation when a callback makes all the
> logical work it should and it just hasn't got enough time to perform a
> completion before a timeout on waiter's side occurs. And this behaviour
> can be named "racy". But, technically, this seems to be a rather valid
> timeout.
>
>> [1] https://lore.kernel.org/lkml/9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp/
>> 
>
> I don't think it's a similar case because wait_for_completion_state() is
> interruptible while wait_for_completion_timeout() is not.

Ping, Hillf?

-Toke
