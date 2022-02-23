Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1A4C1CA7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbiBWTx4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 14:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbiBWTxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 14:53:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565AF4C40D
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 11:53:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s1so12833430edd.13
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omK5lp/Hl9aUYrg40cetPGZCoo2SEfI9aO/EhsJxbHY=;
        b=nrFJVhcxMGTh00wAXNphHXY4GVqX5YfwkEe2oL1Xp7lRsYG9zFmvPGCgkLW+QHLQxR
         a7RdAvNws+CcXcdtiWY/+C8gDWSef/Our1VBZOqPKMQIJJ2WPbhpbA7htdFjORirJn1R
         c0oH5NVVCtUmOg+3gGiwi1wdiERJrQK1PRZDd3oPVk09WzubUv8j1E92upLOAjJ9buFP
         Myn/d5yfPmG+5fKLYhyJLoYR7Ea/nQl9uZPRy0zZYe7OeuyOW819Y01DDeqHaNLHP3UA
         2l1M6r4KHCjPmTLKMvVEpc4GM8aau+BpDP2ymmFWE2qK7hIn++JEURy6Owm4Qu+wNfFC
         Ln6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omK5lp/Hl9aUYrg40cetPGZCoo2SEfI9aO/EhsJxbHY=;
        b=LzM1wsqMTArCAOQJLc3cAq6pWODiaCa2l/6i4TcOhzCugYHBxrnpYMsUqDZq/oo8c+
         T3Uuz7tFyrCq/Up2XIPzXtnlEhsP0NG2K4Le9YJCvtCQjFHazGtVKB5b+l6dXiWRkZHo
         2MECl6pXyasQiy6JFMXg0Uc5lLUUJXvTBAejOsaDfGXfpOcoiRIb2BouXAQk0OZ+B5uA
         YaLHkWQ27vDto+AgxT9Kn6e8csajLG1pK0fJBeEe5qRXKLfzlbXKb+Muns3tiRVB0Fjh
         KK6v3ZP+qyv1qpqwWDGCAEKE5ecXeySCWMH/YchUSEX6peyHsAKBhzYoauAqo4paEJw8
         8zfQ==
X-Gm-Message-State: AOAM532bkiFDA3LoJBMkNgmSIYI2VlwTMwaVfwEdhf9We5HYQOoaH8JK
        OHz5VpJXy5Qvzfu2z/B54K0=
X-Google-Smtp-Source: ABdhPJwiCelisoLjizTM0xr70H4drk2jeTMPH7tc4BMPtSGmQQiKUblfwATXZpLAq7zptn1Jb6O3dA==
X-Received: by 2002:a50:9e85:0:b0:413:4f26:213 with SMTP id a5-20020a509e85000000b004134f260213mr607708edf.266.1645646005813;
        Wed, 23 Feb 2022 11:53:25 -0800 (PST)
Received: from debian64.daheim (p5b0d779b.dip0.t-ipconnect.de. [91.13.119.155])
        by smtp.gmail.com with ESMTPSA id d12sm318148edy.17.2022.02.23.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:53:24 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nMxhT-001Rgf-WF;
        Wed, 23 Feb 2022 20:53:24 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-firmware@kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>
Subject: [PATCH v2 3/5] ath10k: QCA9984 hw1.0: update board-2.bin
Date:   Wed, 23 Feb 2022 20:53:21 +0100
Message-Id: <623e92dfaae9117e59c9ff9c9d1189295072d034.1645645875.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <63972ee8daa620c57eda5eb89221ecfeb55f46af.1645645875.git.chunkeey@gmail.com>
References: <2ce6ca92f529aca13984db205ed38fa0fa6d436f.1645645875.git.chunkeey@gmail.com> <63972ee8daa620c57eda5eb89221ecfeb55f46af.1645645875.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syncs linux-firmware.git with the latest releases from Kalle Valo (QCA):
<https://github.com/kvalo/ath10k-firmware/tree/master/QCA9984/hw1.0>

Includes the following changes:
069b752 ath10k-firmware: QCA9984 hw1.0: Add ASUS RT-AC42U specific BDFs
c0b6196 [v2] ath10k-firmware: QCA9888 hw1.0: Add Linksys MR8300 V1.0  specific BDFs
43ebf8e ath10k-firmware: QCA9984 hw1.0: Add NEC Platforms WG2600HP3 specific  BDFs
26dfc83 ath10k-firmware: QCA9984 hw1.0: Add Buffalo WTR-M2133HP specific BDF

Cc: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1->v2: sent to linux-wireless + ath10k mailing list too (Valo)
---
 ath10k/QCA9984/hw1.0/board-2.bin | Bin 171916 -> 232684 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/ath10k/QCA9984/hw1.0/board-2.bin b/ath10k/QCA9984/hw1.0/board-2.bin
index 6530e163c7c21652524afec0b0cf3ce45fc82704..82dde6372d8804ce974b62a6a1e9f9efb9eae9a7 100644
GIT binary patch
delta 5491
zcmeHKZ%kWN6o2<YY5BiG%UF4o*HTK`wWahm1WgxV8`=#aWn+Ryfy#ozLD%t5W`M`C
zO>rSx>y3M8)S>&bn8hG(u9z6KA58e7>HJKV=?CS5EX_iQCS-WuqopNKC}GeT_e<V=
z=bd}*J?EZ#&$;J~{*dz5#~H(y!CidxrpKR{>?*-{RCpBX<7N6jM_0SU*>mV{Z(EzA
z<D8+P{)C~%TuM<kJ3w+Ik|s-}^8jR7Ug>vdjUb-%A!=GMthXVB6Txr{OQ$@(JdZmQ
zV4m@6@IB*t8K~gwd^rHj`Fv24G_{OjSMPbg(ZlKMDRB7Fg#?*Q1_Lb?k6+{s)PUbb
z0AuRfal?%U&_ox;7uuNBdwde_v<58UiK8El-+_)L!ut!2(?aMUTxLzVEduY<bHFZ$
z_ky13k9kLTMKIp}7x1fMeS=GYdDsO6Li{u~I)3+OmV7Twl-v_c2uD#uD6_04gxabj
z278C2r|n!<XSbo@C3Bg{WV2J@r0~f<0AL9;$_pd#{Ix3RoPUeWzkWZ3-X8=JA82A#
z>-F6O%{g@bIuOJ<R(|X}c@PA#LJ)*Zwh51xZzZ@BV>TMQ))-oj4A|7d-8JydbtZ=V
z!5J2l3%8PE6n_Azcj6|P!&(2gQ^GYz{xB8$k$?NejqX7yt7y&yU<!%@rNR5{0DGk+
z{l66n;so}%vo`x#IQ&1tfelQK;9hha<cb)H3oofPhvT55-FdeALbsu_tDG{K41Fd;
zTWf1)IP=@igu<Zu5?>Bh@a5n;s1QWhhblq}8k+OOt*sbeAYv3nEj)gVRWrYR1steI
zTt?t!QM2FUQ)Faf!z4yl9!<pT0=s}A2Y^I(AT=byy<ZUEJOBU*Az;`9S6BY(@hQP1
z`~v9Vl@>en7n4*@P7cOBA#CxTjsWZGX4rt^Pa#tv!NvO}!o|OzJdvUa%C$v>N~N*@
z!}8OFaJgN|ye`3qXiFGolTokJs4SKsp+sG~&C|xL1Qn^U_N*lTOIPo^^yLq(!Bt|6
z+ZYZk1@EURVU@MrskMfn-Iz3m`mHAI%4pO^k=3or>LP~eR)^`J_|Pnz_*BKr4&hlU
zwO+5kqg`qBX0v&+B$Bg2!$5|O8Tt;?!=|MQ_Nuc<c*{QsZq4-xa`A*jL6T6EoRXTB
zo{_mvoRuw+=H$xqJ{%xDK8;{vq`$F(aijpL920Q|lhl~XD{S`0mNTyY;Su-P`0a_Q
zA7^G};Phwp9)B+DuIUG?e{cXKEiNuDEG)2}KbQpEzVmyl4(+#EN$w$!*2PJ2P%n*+
z`rfX1?Shg2<LQ1K9bfkw6FK)Yj`x8S9nHCwdOj7^^NnM-e*!20djnnIYfya<#TZIj
zN>v2-uq#C&sX@?1fRECsBcMWi17=PQ(orRzV#g-t9gDJ}?Q3T*>f8YO^){Q9QU`%@
zSOi^SMX88~)f&l<Mk61&VZczPD(0rs8@Zv@6?%P(gl+KA8wX+MtT(wM`1kcZ`ui#h
zU%{0pPn|TJs5ev|v6xSFM%=v@Ut?S@oM1K0qV*+bwu0vNR-;iDk_7isDM?b!QQXH~
z@aWi-AX|8|A`N^hJUU{<JD8BOOHQcKOF<UM2^sIdSa`2;j*dle+j6Y)(&@x%l`#sU
vb`%?px(&yy#&uMQz3Dg>#lG!p5687!8(MOaaVPX@Toc@U%FWwgTtE01AI#*U

delta 13
UcmaDeldoq#S3?Wq7N(y004sO}&j0`b

-- 
2.35.1

