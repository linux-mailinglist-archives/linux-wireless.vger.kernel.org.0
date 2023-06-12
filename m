Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9472BB80
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 11:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjFLJCY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 05:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjFLJBi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 05:01:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2759113
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 01:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC6161358
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376F3C433EF;
        Mon, 12 Jun 2023 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686560294;
        bh=oTtc31fgR9yIREoxJm78IfnfB6txNUPj6ELcbjX9zjk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JlDdurCthD/LB2xXxHUksysZZv4f4GNxBP3LBDqD88/xeO15U20Jb3+4yTDCe1TpY
         edQW4WjJhEveJXMW9D4Jtker0c1oQDLTonAR03GCB1o9ofoxG3wOSifNz6Pp77Thn/
         IffTXrDzU6FNcYNlSnBwdLJhB2exYBQ9rhFVECbQgWAnruWKhzMJUBRNweGwTvxYk0
         14h9xru2AqLyE3+LsgdViCrBBqx5M6jSop4T3OO/0sVz3OJ8YqdRjXnhFGxiTnIzt+
         LFAGNmbW1wML4zQOFENHpJI+A1d7UH099de0zs+FuBfQTZiQYBWk66LtSzUQIE6yvN
         KRQZZaRzFw3mg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "lorenzo\@kernel.org" <lorenzo@kernel.org>
Cc:     Deren Wu =?utf-8?B?KOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
        Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "lorenzo.bianconi\@redhat.com" <lorenzo.bianconi@redhat.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd\@nbd.name" <nbd@nbd.name>
Subject: Re: [PATCH v2 15/15] wifi: mt76: connac: add connac3 mac library
References: <cover.1686298162.git.lorenzo@kernel.org>
        <b7a029d6dfee8e58c58f483ea9e9e7b3bc8012b9.1686298162.git.lorenzo@kernel.org>
        <5010e5e508e89041451288659390fde5ded94db5.camel@mediatek.com>
        <ZINUnqkElqSOITxT@localhost.localdomain>
        <82971c76999ae90be44a524fb95141c5051a9ba0.camel@mediatek.com>
        <ZINXGP6TmDLaZ+lu@localhost.localdomain>
        <79bfbe146c7f19cd22007f759bde92c9083c5594.camel@mediatek.com>
        <ZIQq8uFMgjphE+v+@localhost.localdomain>
Date:   Mon, 12 Jun 2023 11:58:09 +0300
In-Reply-To: <ZIQq8uFMgjphE+v+@localhost.localdomain> (lorenzo@kernel.org's
        message of "Sat, 10 Jun 2023 09:49:06 +0200")
Message-ID: <871qihgiqm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"lorenzo@kernel.org" <lorenzo@kernel.org> writes:

> On Jun 10, Deren Wu wrote:
>> On Fri, 2023-06-09 at 18:45 +0200, lorenzo@kernel.org wrote:
>> > > On Fri, 2023-06-09 at 18:34 +0200, lorenzo.bianconi@redhat.com
>> > > wrote:
>> > > > On Jun 09, Ryder Lee wrote:
>> > > > > On Fri, 2023-06-09 at 10:15 +0200, Lorenzo Bianconi wrote:
>> > > > > >  	 

Guys, please edit your quotes. You are now sending mails with 1000 lines
and that makes it unreadable in patchwork:

https://patchwork.kernel.org/project/linux-wireless/patch/b7a029d6dfee8e58c58f483ea9e9e7b3bc8012b9.1686298162.git.lorenzo@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
