Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0167E69EBFD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 01:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBVAdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 19:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBVAdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 19:33:38 -0500
Received: from titan.fastwww.net (titan10.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12684E3BB
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 16:33:36 -0800 (PST)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=bJBXo7ZwyddsxvbF6trwUeiPRCIPmsSNPzh3QcESr8PcRIffGIIdIqGkWShIqZ42xunjU7GXmxZLpk5Y30qqockrU1147dZ73qRtNeN99IYvCNu51mtkmHGED0X4gvky83zlB2LoXT2wVR0IAQk8ZgCJhTiFRTSpB3FT//zDR5+p4K/qPTj+NOw9tdUA7Y9qrEG391Ytb0cw/tIBrbSgTwICecE0vcKwDNC1E4I37Gwkvrb6HCanCpACbVm+hcVyLFv5dPQjHgNtthC9dmoPKw4RMTy+/tUyPopm1I6fUuwqx7G2Aj4Qki9ypXqIxuIv7ZtbNPNWkC83jy3/O2/QiA==;
  h=Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:From:To:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=lockie.ca; h=message-id
        :date:mime-version:subject:from:to:references:in-reply-to
        :content-type:content-transfer-encoding; s=default; bh=5/hpLmAHM
        dfY8jJBqmToeDN9+cg=; b=styaSCQeptmyYmg+pHFcIWxKbai4rarGht2s2u9nv
        ICaZepD6WSu4Abmb9J9c8ylwnA2Apyig43YdzCuScuS7XCv+TT0+oV8I0F3MEZ8T
        7ePZ7T31tqNNhpHAYgtHZIJJ3lIGnD44gspJ8zBEIgiPUp3unF88Hc/IZ0j4ikRB
        vlsCxdBS1+SupxMzJ8jYrwoK6g7LRzauFLrjjZ74qkJNgAIf0lsnyEmdgpvP7Xv/
        ppDs+6atx/vDlBBIlp5NGcy2klb9QDoNEnuNhy8mU/XG4rSPa9WvT9LU9Qi3G6QV
        nXwFb5fhWTq2rOlgqc2fVn4gF+NyWWAO5N3p5tDwtAcXA==
Received: (qmail 21844 invoked by uid 108); 22 Feb 2023 00:33:36 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 22 Feb 2023 00:33:36 +0000
Received: from [192.168.68.80] ([98.124.13.21])
        by titan.fastwww.net with ESMTPSA
        id DN7KB+Bi9WNSVQAApSktOw
        (envelope-from <bjlockie@lockie.ca>); Wed, 22 Feb 2023 00:33:36 +0000
Message-ID: <55948006-b405-13c6-ce31-456783caf358@lockie.ca>
Date:   Tue, 21 Feb 2023 19:33:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Bug report about ath9k
Content-Language: en-US
From:   James <bjlockie@lockie.ca>
To:     Vincent Danjean <vdanjean@debian.org>,
        linux-wireless@vger.kernel.org
References: <ad820d2e-c984-8603-9821-e6c1d426c4f8@debian.org>
 <f3039ab6-25f4-d003-059a-c0a75aa24127@lockie.ca>
In-Reply-To: <f3039ab6-25f4-d003-059a-c0a75aa24127@lockie.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2023-02-21 19:32, James wrote:
> Try disabling power saving.
> iw dev wlanX set power_save off
> Maybe that command.

