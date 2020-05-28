Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80321E66BA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 17:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404581AbgE1PtE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 11:49:04 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47889 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404542AbgE1PtC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 11:49:02 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9C447A0F
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 11:49:01 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute7.internal (MEProxy); Thu, 28 May 2020 11:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm3; bh=ZjIyY2t+T7o6kEo1qjWU0rAD640q46uU23qh6ON+RtM=; b=XslSpmMU
        5APkJ09XlKmkoerRUEKVD7Tbcee7PyfpVyu0UyG/66R+PQBmqbGZhHkfp0gib+FP
        rZfVtJMrgJRYgNn2EqA+PYCnj3gj9xpNrHP5FRrWDBxZ32STBDLopTm4XFmOPvCO
        jNeV296MHqFiszeA3YjgmsKvGdbaAsqfFoE4cUTN5mhAVwpTz7iiFzFk+ny6YJEJ
        saG+S7OzBkP85Kr4j6r0aYHAXmPEXkJI4SwaPO52TlWoJmjeo/01zXubn50AaSzN
        ZkyOa92+hF6lZhD3jli1vdSSTYY9T+lU/BER1gt3rOnl/W9uh1dGHV2qlYbLPnXx
        rQUEm670Ez3TEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=ZjIyY2t+T7o6kEo1qjWU0rAD640q4
        6uU23qh6ON+RtM=; b=ohMSvmvYQu7QQWUh472p/eZhWqBFkgmqigMuBtlFHtUaW
        p/VESkYknGj+MMw1LZcmLaDHlXYb2LFVPnYVNcQVMzALWydHLCgvpmQQgx41GdMg
        2F6/VIkiiC32k/z4xzUBKmshKG+QF8grL/dtdqE5RkmXsxrc1QojYct8WBdP7P40
        eaS1gw9Vn6uPWx2zMHSIt2kV1mpNR9gaMTFyWmWgYJd0JsqztmS6Nt51+tjA/aQx
        R76l2uqtdD3+at2xAJ2ZzPp36t7rEa91Lhkr5FUyfpkjAiVLWj7Vt3kMoXTUbIm+
        TUJKvAGOWkDmgmsZ1OtviFEmrT/L1DSVbQ660CvOg==
X-ME-Sender: <xms:bd3PXiyk2PajLanu77nOAk_LUqIMUl2dQ_6o18gBbHB6X57tqETugg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddviedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfuehruhhnohcuffgrnhhtrghsfdcuoegurghnthgrshesrghi
    rhhpohhsthdrnhgvtheqnecuggftrfgrthhtvghrnhepueehgfejhfefheeuveejtdeive
    fhteduuddvtedutdeuveejtdefjeefveevfeffnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepuggrnhhtrghssegrihhrphhoshhtrdhnvght
X-ME-Proxy: <xmx:bd3PXuSKQ4YVNGqGXPn9XdgWcD-1kjTtSEAWvmSn9gSHf8Mvgx5EWQ>
    <xmx:bd3PXkVTG5NIMZZgjtaxXXc03hrnVRz3wF7YFwvFuH2Qf5SslmTKWw>
    <xmx:bd3PXoje8Q2JHuiO5z_pIFqxpuIIPwHNymS0h_oww7Q53mhNuCo7Yg>
    <xmx:bd3PXszpMDFyyobx4RelsFiEI09v_1kyh5kvmwL_7GlGr5TmLM7X5g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01492E00A9; Thu, 28 May 2020 11:49:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-504-g204cd6f-fm-20200527.002-g204cd6f2
Mime-Version: 1.0
Message-Id: <afef8a7d-053e-4aaa-ace7-d320c32e8b7c@www.fastmail.com>
Date:   Thu, 28 May 2020 11:48:13 -0400
From:   "Bruno Dantas" <dantas@airpost.net>
To:     linux-wireless@vger.kernel.org
Subject: iwlist scanning: how to exclude old scan results from output?
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I hope it's not too inappropriate to ask a support question here. I've tried at my distro's forum to no avail.

Please, how do I make "sudo iwlist <iface> scanning" display only results from current scan? Cached prior scan results (including no-longer-available hotspots) often show up in the output, which breaks one of my shell scripts.

If iwlist does not include an option to ignore old scan results, a workaround would be to first flush the results of old scan, then scan. The problem is that I can't figure out where prior scan results stored. Surely one of you guys would know? The only way I've found to flush old scan results is to unload then reload the wireless interface's kernel module, but this approach seems heavy-handed when a simple "cat /dev/null > somefile" might be sufficient if I knew where old scan results are kept.

Thanks a million for any insights.

-Bruno

P.S. Here are some possibly relevant details about my system:
  - OS: Tiny Core Linux 11 64-bit
  - linux kernel version: 5.4.3
  - wireless card: Atheros AR928X
  - wireless driver: ath9k
  - iwlist version: 29

