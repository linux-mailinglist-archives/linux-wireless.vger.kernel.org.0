Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC4677138
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jan 2023 18:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAVRs6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Jan 2023 12:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAVRs6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Jan 2023 12:48:58 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1213509
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 09:48:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d14so5198881wrr.9
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 09:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/Vl+e288mnI5T4nxm8bMtlKXYNlEWQW05Lp5Br+Aww=;
        b=ct34pcwAirwUqnx/MJ7nXUuKKsZ2J7TNKdV57O0F4IpTvXrwVEIzpKUhpS9fNyNJQa
         3TxdmXVhUFRzgNGNyWPtCj9dbHnhg9ml4zuf2TqSG0SeijteHt4+zEtY/f1/56YiS/Rq
         i83ZHB8xag6tcMQeVClGrC60JDu0oGea9C9WIA7eIfUJett7gO8FNnHy76KMZtiDAVYu
         vicN6JkxAVHKMfhyym+lMRC75tCQgrAKD7MrWfTa4TX3NNGOF40ynvU6ptaRDkBUF2lr
         cws1FtrMIEecrIvtqXuBg8yhz/Wi3kEIJIpw4Fg8Hw5GtYH75EipkQnu58AT1+MYWykQ
         jgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/Vl+e288mnI5T4nxm8bMtlKXYNlEWQW05Lp5Br+Aww=;
        b=c0T57SKtibVCQG34VE+Ao9nz+gYP2wTW6Mi9723Cx9sy12lVqEsepD8Vt8w/smCZxU
         aCzrY21bdLFT6UJ0qqiv/RgFY+CPgq3B42JCjXpOvbPAW1j9jigl8W6luHQACen7gRCZ
         SpyibQIwnh3vVHvdEqVLQq5dgVIbBD4xUf9yjgSeHz6uVDp8/mzP7a2lw7/JjF9ChNRF
         NjGH0enKedeE3g3FkDJSF6OIVghqMKA8HxX3eJoLdAWRzEm/1EfjMPOuS8U089zBpNe/
         EGS8xofU2n5sBolxEVwq4iXqGP57un7PGWqzsy6mCEBho6ngIAIlKklcbGqwg3LhXh54
         ZFeg==
X-Gm-Message-State: AFqh2krCz8dR9YtjTiZ7oCAD7s2cS09JdeJzCsDUfn2yRL7m0++VgM0u
        yVrsRee1pmNZI38LW3HhkJJV5i6uB5WQ/mA+rNA=
X-Google-Smtp-Source: AMrXdXvnRFdehvIUKJrvJHyUjBfKtFB+pvOf8Cn+Wy3BQenzlvlPx8JW/TK7C6pHp5+78DJrV7UmpQ==
X-Received: by 2002:a5d:59c4:0:b0:242:1b0d:9c58 with SMTP id v4-20020a5d59c4000000b002421b0d9c58mr19953991wry.69.1674409735117;
        Sun, 22 Jan 2023 09:48:55 -0800 (PST)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id j10-20020adfea4a000000b002bbdcd15e44sm648987wrn.37.2023.01.22.09.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 09:48:54 -0800 (PST)
Date:   Sun, 22 Jan 2023 17:48:50 +0000
From:   Vincent Donnefort <vdonnefort@google.com>
To:     linux-wireless@vger.kernel.org
Cc:     luciano.coelho@intel.com
Subject: [Bug] iwlwifi microcode error
Message-ID: <Y813ApLzGgNMHMBu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

Recently, the network card on my laptop (AX201) started to lose the wifi 3 or 4
times a day. When it happens, the only way I have to reconnect is to restart my
network manager.

I found in dmesg the following:

iwlwifi 0000:00:14.3: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 6
iwlwifi 0000:00:14.3: Loaded firmware version: 71.058653f6.0 QuZ-a0-hr-b0-71.ucode
iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL    
iwlwifi 0000:00:14.3: 0x0000A200 | trm_hw_status0
iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
iwlwifi 0000:00:14.3: 0x004CBE06 | branchlink2
iwlwifi 0000:00:14.3: 0x0001AB16 | interruptlink1
iwlwifi 0000:00:14.3: 0x0001AB16 | interruptlink2
iwlwifi 0000:00:14.3: 0x004C3E98 | data1
iwlwifi 0000:00:14.3: 0x00001000 | data2
iwlwifi 0000:00:14.3: 0x00000000 | data3
iwlwifi 0000:00:14.3: 0x96800FF7 | beacon time
iwlwifi 0000:00:14.3: 0x424B6011 | tsf low
iwlwifi 0000:00:14.3: 0x000001FB | tsf hi
iwlwifi 0000:00:14.3: 0x00000000 | time gp1
iwlwifi 0000:00:14.3: 0xACE77E1C | time gp2
iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
iwlwifi 0000:00:14.3: 0x00000047 | uCode version major
iwlwifi 0000:00:14.3: 0x058653F6 | uCode version minor
iwlwifi 0000:00:14.3: 0x00000351 | hw version
iwlwifi 0000:00:14.3: 0x00489001 | board version
iwlwifi 0000:00:14.3: 0x8008FC03 | hcmd
iwlwifi 0000:00:14.3: 0x24020000 | isr0
iwlwifi 0000:00:14.3: 0x01000000 | isr1
iwlwifi 0000:00:14.3: 0x08F04002 | isr2
iwlwifi 0000:00:14.3: 0x04C3200C | isr3
iwlwifi 0000:00:14.3: 0x00000000 | isr4
iwlwifi 0000:00:14.3: 0x04B1001C | last cmd Id
iwlwifi 0000:00:14.3: 0x004C3E98 | wait_event
iwlwifi 0000:00:14.3: 0x000002C8 | l2p_control
iwlwifi 0000:00:14.3: 0x00018014 | l2p_duration
iwlwifi 0000:00:14.3: 0x000000BF | l2p_mhvalid
iwlwifi 0000:00:14.3: 0x000000EF | l2p_addr_match
iwlwifi 0000:00:14.3: 0x00000008 | lmpm_pmg_sel
iwlwifi 0000:00:14.3: 0x00000000 | timestamp
iwlwifi 0000:00:14.3: 0x0000D0A0 | flow_handler
iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
iwlwifi 0000:00:14.3: Transport status: 0x0000004A, valid: 7
iwlwifi 0000:00:14.3: 0x20003463 | ADVANCED_SYSASSERT
iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
iwlwifi 0000:00:14.3: 0x80455B7C | umac branchlink2
iwlwifi 0000:00:14.3: 0xC0081200 | umac interruptlink1
iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
iwlwifi 0000:00:14.3: 0x424B6003 | umac data1
iwlwifi 0000:00:14.3: 0xACE77E0D | umac data2
iwlwifi 0000:00:14.3: 0x96653FD6 | umac data3
iwlwifi 0000:00:14.3: 0x00000047 | umac major
iwlwifi 0000:00:14.3: 0x058653F6 | umac minor
iwlwifi 0000:00:14.3: 0xACE77E16 | frame pointer
iwlwifi 0000:00:14.3: 0xC0885E00 | stack pointer
iwlwifi 0000:00:14.3: 0x0023010C | last host cmd
iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
iwlwifi 0000:00:14.3: IML/ROM dump:
iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
iwlwifi 0000:00:14.3: 0x00005710 | IML/ROM data1
iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
iwlwifi 0000:00:14.3: Fseq Registers:
iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
ieee80211 phy0: Hardware restart was requested

This seems to only happen when I'm connected to a 802.11e capable router and
after my firmware has been upgraded from 20210818-1 to 20221012-1.

Is that a known issue?

-- 
Vincent
