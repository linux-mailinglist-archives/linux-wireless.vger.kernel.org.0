Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651357F2D83
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 13:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjKUMqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 07:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjKUMqf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 07:46:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E34CA
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 04:46:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A2DC433C7;
        Tue, 21 Nov 2023 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700570791;
        bh=Zvq1L3qrO60z+9+NlymajsWGGa36ovjavLPOBw9MDV0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Lr5y7QhnKA1IIVN3FzyVHj5533EIhg/AZBFEf0KBTX4lFSQN52jtsoNvAECK3M5tg
         JCjxvxBPfomLo6GEvA2A7sLyiEjmXmMNuxJ6NtZuWIO8a8Po1BSpsemTD1zPzs99tG
         vE485swaVZIAT1fbO4tsMDPHQzLYYE56IpUEgXL0G2G22xHATIP2ySJ5hx8BgE+LVv
         MoUn6Vp3U9fN7W7lmJVW/JuV6o+SzGb3a68B+7v35VsVylPW4Nx5MfThZIkBs/7mht
         i6yxBjywD/LHbEX5+rQpcGJKYuNQH1KUkZMC3VP8YQXC1oCUyYwDYBadF3Xbd3SKww
         d371gdtiV/1eA==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: mt76 DT binding: undocumented interrupts
References: <CACna6rwZ8q1Zoz4UAryipsZ90yVD86BrcTNv1yKyS8F4DXsuSQ@mail.gmail.com>
Date:   Tue, 21 Nov 2023 14:46:26 +0200
In-Reply-To: <CACna6rwZ8q1Zoz4UAryipsZ90yVD86BrcTNv1yKyS8F4DXsuSQ@mail.gmail.com>
        (=?utf-8?Q?=22Rafa=C5=82_Mi=C5=82ecki=22's?= message of "Fri, 17 Nov 2023
 06:30:32 +0100")
Message-ID: <87zfz76zq5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> writes:

> I noticed that Wi-Fi on mt7986 has 4 interrupts instead of 1. See:
> arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> 300218b0503d ("arm64: dts: mt7986: add built-in Wi-Fi device nodes")
>
> Those interrupts seem unused by Linux's mt76 driver and are
> undocumented in mediatek,mt76.yaml.
>
> Can someone explain what those interrupts are, or just send DT binding
> update patch, please? I'd like to get DTS matching DT binding and
> passing dtbs_check validation.

Is anyone looking at this? Peter Chiu, why did you add undocumented
interrupts?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
