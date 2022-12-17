Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CB464F60E
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 01:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiLQAXd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 19:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiLQAXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 19:23:03 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C04E66C3F
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 16:17:35 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c13so2823800pfp.5
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 16:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QCEzTClqaLwm8b7LdtrwUIb0xI1a/zfcvEW6n9pxC84=;
        b=Rw8QAIDNODgMakBDTNa5Qi9LdQzLT0DViBC5st7zWlvzB/nu/mKiHpdp6mqft2FA/b
         sNuP+YGFH68UqixCF4QPGg5H6s1Rt4NMPqxgzIQQ35Q4eFoMBSNPINVFqVerUE+Xu4l3
         EG3kGDTzMmvQF1EXEfbYI0PXv02MT5T3l69Lmj9wdPByGYgIBfe+Ay76EigBr8TW8UEb
         Ide6qU987t9TmCQaE141HZf9IlGPfC+fE5ttOo/REEgsvUjWiTw8+0UZQvpilIpkR4yK
         ln4P71+GOP956kv7tVwyqcRqX0v5g0GRWrbR86N//Nvt94sDUGgpKSgAMg7vDKanZ20q
         kZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCEzTClqaLwm8b7LdtrwUIb0xI1a/zfcvEW6n9pxC84=;
        b=KpKY9nvbv6HY4EHf+S8nJfGhGJqS2zjmvaOTmXwhEQb9wRD0DlKFw2CuX9nENU8Jq/
         g/XXwconnsRxNgKIhCz6J3vvMjsmdMlL435MQmKWfLt5ZF/xvT8iVb2YosUAovf8qyTQ
         RAfQOSV8nl7q2F+LIBiAWlT5E3csKpT/wdB5MUFmhHtOe+8O08ErNc5CrLMVQBAj3Btf
         2MoZqBtJQcUBYvha2qYE7gkCS1oS12PMUrGl5A73M8b6Slx0S37vh5Vz2eZRqyMQHmub
         EbnTLCEd9VyLDHGQ7bfAgzDMKKR3TlABFidZOClJQw1a8BujozUn7vmBZebGxtLb4Jn1
         hD+g==
X-Gm-Message-State: AFqh2koBA+0Aw3WrTPVRsORxBFddJlJaBDd98NmlsNxBBpTLc3PpXZka
        QHV1kA7PNDLiQWfpr0/PDri1fNxd9a4=
X-Google-Smtp-Source: AMrXdXuYkapf9Rumgkt62vXmM8v9sRyfMBUIBK+r8Apkqr5IOOex/sQXm54LUr7rgMrevXu3uDEXlQ==
X-Received: by 2002:aa7:960d:0:b0:56c:3fba:c5ca with SMTP id q13-20020aa7960d000000b0056c3fbac5camr351609pfg.16.1671236254340;
        Fri, 16 Dec 2022 16:17:34 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78f34000000b005776867a97dsm2048471pfr.29.2022.12.16.16.17.33
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 16:17:33 -0800 (PST)
Message-ID: <ffe143aa29161635530d4c0e6cea866f4c41267a.camel@gmail.com>
Subject: Why does HT/VHT/HE/EHT depend on WMM?
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Date:   Fri, 16 Dec 2022 16:17:33 -0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I noticed this bit of code which disables HT/VHT/HE/EHT if the AP
doesn't support WMM:

net/mac80211/mlme.c:ieee80211_mgd_assoc()

/* also disable HT/VHT/HE/EHT if the AP doesn't use WMM */
if (!bss->wmm_used) {
	conn_flags |= IEEE80211_CONN_DISABLE_HT;
	conn_flags |= IEEE80211_CONN_DISABLE_VHT;
	conn_flags |= IEEE80211_CONN_DISABLE_HE;
	conn_flags |= IEEE80211_CONN_DISABLE_EHT;
	netdev_info(sdata->dev, "disabling HT/VHT/HE as WMM/QoS is not
supported by the AP\n");
}

It seems suspicious that 802.11 features would depend on a wifi-
alliance spec. Usually its the other way around.

I can see no such limitation set in 802.11 or the WMM spec, so I wonder
why this was done? If someone could educate me on why I'd be happy to
update the comment.

Thanks,
James

