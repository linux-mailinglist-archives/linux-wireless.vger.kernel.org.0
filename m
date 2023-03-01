Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E16A7294
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 19:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCASGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 13:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCASGI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 13:06:08 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259E3C7BB
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 10:06:03 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 04E48582018
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 13:06:00 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Wed, 01 Mar 2023 13:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sklein.xyz; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1677693960; x=1677697560; bh=wlfWRVMKfy
        2D4TIvJmrONXSljYcME30cBXzk7k6dvmI=; b=GHHnh2uY/GlHOKqThasMy2Nog2
        C/g4If4arwgqrca9diBnp2Fyh/uI5BWu+zKVI5fUyGdEX+zp0YY790ROAx9cNdgK
        uaaVVb4ZOHeohRInWYC7FcYxPS5RxLZlZQ4yKdnTtw5KPdSiNSF7STp1jY3x5Jg4
        CrDANTiOlb+KlGKF8yF1/+bBdBZ5z81Ks7s89L+YSfJ3CpsCF9InAPlz4lMA7Ny+
        hyr4gWM2UZp49cuHjKWqRSXPM6VfmNfzW521WTYe5my8v29rlh4TLNTkvypQhPrV
        mxZ5sIyJh0BFXwcOdHcj0u0CEP3WOQEpSmHggDE0lCGOC44ajag89Kyt2LNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677693960; x=1677697560; bh=wlfWRVMKfy2D4TIvJmrONXSljYcM
        E30cBXzk7k6dvmI=; b=eFiuKx9gI2DECkP7+gPsXhtPdYjitI+zUPxzdTQUrZay
        BHgZbA1knG7fL/B/FZIY/s4dL8C3LdFEH2NSd8p2IXP2vkeRjRptOldibdJvDFPq
        787lOjhBmK9mSIEYGtmVYwVy2cjJV7wPGXiYypm2l7EMyc7Tigphx07TYd1FyY5s
        EhFolnDZATpNiWL0QlAbhL8Huv4GaVEyNkLYfhl+uE2SRCJqLtjGoRkQVtJmw8TN
        AhQxk1OLKIcvJAdNx0tWk4bWYUEBsf74fQB+tTThIwcCsYFig7svCb9ZE+rRMRt8
        M78mZGMKyzmGiYqeUXVTG3kCsSNQonOsAg+zLve6xA==
X-ME-Sender: <xms:B5T_Y2uK-u1EHPRA_TPa_jaGLYwr4FRKDOGUU1az3P541Qd90ESo0Q>
    <xme:B5T_Y7ctoxgHyH3Huot7dLp0y5WaEGiOWbPjXlsN3eNU4rb2oGf9ixXbn7_bDox71
    0KQxvRvhiVv_Tu6dPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhepof
    gfggfkfffhvffutgfgsehtqhertderreejnecuhfhrohhmpefuthorphhhrghnvgcumfhl
    vghinhcuoehhvghllhhosehskhhlvghinhdrgiihiieqnecuggftrfgrthhtvghrnhepie
    ejheelveegieekjefhudfgieejtedvveehfeelvdejtdfgveekueehieeviedvnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehhvghllhhosehskhhlvghinhdrgiihii
X-ME-Proxy: <xmx:B5T_Yxw5oebaahwJ8NfILWk3D1CRLidV-YOjFEE5pgkr8-p5KdcEfQ>
    <xmx:B5T_YxPlpz5GqXSYrvzPpeOnClFW5A1THS7vJVeusXctB_JgTQ7Xtg>
    <xmx:B5T_Y29fE2kquc639cBMbeYjEC2B9VvZdGYyyRLwcZUcV6aSGjBpmA>
    <xmx:B5T_Y5K3C0zNhDx_vkIbU0RlYRtfRB8jwTqZ1rm5k3HuZ4melk4sPg>
Feedback-ID: ic6c94672:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B7C22A60082; Wed,  1 Mar 2023 13:05:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <3ae33154-126c-42b8-a3cb-eeaa63c7a6f7@app.fastmail.com>
Date:   Wed, 01 Mar 2023 19:05:39 +0100
From:   =?UTF-8?Q?St=C3=A9phane_Klein?= <hello@sklein.xyz>
To:     linux-wireless@vger.kernel.org
Subject: ath11k_pci 0000:01:00.0: failed to resume hif during resume: -5 after
 hibernaton resume on Thinkpad T14s Gen 3 AMD
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I try to configure hibernation on Thinkpad T14s Gen 3 AMD. See full cont=
ext here: https://gist.github.com/eloylp/b0d64d3c947dbfb23d13864e0c051c6=
7?permalink_comment_id=3D4474569#gistcomment-4474569

I see this error in my dmesg:

[  210.043130] ath11k_pci 0000:01:00.0: failed to resume mhi: -5
[  210.043134] ath11k_pci 0000:01:00.0: failed to resume hif during resu=
me: -5
[  210.043136] ath11k_pci 0000:01:00.0: failed to resume core: -5
[  210.043138] ath11k_pci 0000:01:00.0: PM: dpm_run_callback(): pci_pm_r=
estore+0x0/0xe0 returns -5
[  210.043158] ath11k_pci 0000:01:00.0: PM: failed to restore async: err=
or -5
[  213.050611] ath11k_pci 0000:01:00.0: wmi command 16387 timeout
[  213.050624] ath11k_pci 0000:01:00.0: failed to send WMI_PDEV_SET_PARA=
M cmd
[  213.050632] ath11k_pci 0000:01:00.0: failed to enable dynamic bw: -11

More information on these comments:

- https://gist.github.com/eloylp/b0d64d3c947dbfb23d13864e0c051c67?permal=
ink_comment_id=3D4488325#gistcomment-4488325
https://gist.github.com/eloylp/b0d64d3c947dbfb23d13864e0c051c67?permalin=
k_comment_id=3D4488341#gistcomment-4488341

Do you think it is a hardware bug, a bios bug or a driver bug?
Or did I configure something wrong?

Best regards,
St=C3=A9phane
