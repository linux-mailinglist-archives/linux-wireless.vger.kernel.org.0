Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A736C5566
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 20:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjCVT6U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 15:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCVT5n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 15:57:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F976A1CB
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 12:57:21 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bf30so8006592oib.12
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seqtechllc.com; s=google; t=1679515041;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kid2Fz7Dt6NAcPGgmC4LQVvf2cElSfG482FZDB3kJ9o=;
        b=ELcMANS4NhoY5rDZWIzrLstp6WvVg4K17Obe2LcBvkwYDQZXqRXmFNFG72YqniK3Rl
         PP8KPPgpV90bkzz1/ZdNFw8M0/RLfBd1AKbFv+167zxLiWBQobauzdpaM9HbkBy0523b
         4x0W9Bh4kXKfZ78ywhdQehvdOMWo+9EZawWEsWdlxWn6ArvIElvaGJWNvHs+0bohLUr4
         UD2mV76soUVWPtmzGjA+mnGqwOmq6bEiM/ckFfEwi5jG14tPl7Ola/6K9u1G399VDHpe
         kEG612oyvUVWBEvF/xaQGjDtx4kFViKjdViYMLM63jhQeVS83zWgMJEOpIfU4J995kpp
         zqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515041;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kid2Fz7Dt6NAcPGgmC4LQVvf2cElSfG482FZDB3kJ9o=;
        b=1whm7MilJpVk/+ISlY7GIfulr8fB9p3ff9QgxZvBoHqo2ZOTkzrz8tgoiZq+tLg97v
         O4Z47Tru8yYFIvwWm7ssoTLhhmerNj0K2O0n5fWjAdRNs3slH8pw2cGI/GuMVZv7HrIa
         HKlsYqoo3+bcEb9QACBxTmiE765Nbh73Jp4ZQxpg7mrmOIvPtr2BmglpvJZwQQgPIDqz
         jhrOsWmWZ1gOhbS4uhL2uWNqEHwq4ZxSFB9gn46JdtG5ZCw5qG09UnJU7zZj+KazhRFN
         YeZ3mTsDkXH/yZesbjs3Exp0TQf2dxmMPwYkePkxkWakfiAdbVr2Zo1nkqRTWUDpF85B
         /5VA==
X-Gm-Message-State: AO0yUKXZerXDbpbspLn3e1wb1aPMqQTe4WaM/zdo0K3BCdm+u3e4swLq
        xYRIGLKS2JVVYkMo9cxGSjN0vTsDSjlXqhmXWh02QeIwuzwhfng4am3rezbAgu7ysPIma2ATS0g
        Yd9KHKUfIKSWwHKIG+SZnOAksgWObmtkq2wRWWiTh0Ifz/9aa5Bo9p3cJvyjNTn7KsB/HMnNgvI
        ApXHsRPugilJZdYrm30I+UefVRSJprmsan9z3kh0yc/AzNmuWEX107fHXqy7mYacULL6DAZA==
X-Google-Smtp-Source: AK7set/iQ9BDIE0j223HwlBlerjVekWPL+P7BBpCx9FKQI+LK2fw8EworfzXD2X2fN+YIDiHo/ZCWA==
X-Received: by 2002:a05:6808:616:b0:384:167d:736b with SMTP id y22-20020a056808061600b00384167d736bmr1669079oih.15.1679515040784;
        Wed, 22 Mar 2023 12:57:20 -0700 (PDT)
Received: from smtpclient.apple ([67.202.189.242])
        by smtp.gmail.com with ESMTPSA id n13-20020a4ad62d000000b00517a7ac36c8sm6406947oon.24.2023.03.22.12.57.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 12:57:20 -0700 (PDT)
From:   Gregg Wonderly <greggwonderly@seqtechllc.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: shift exponent 35 is too large @ ath/ath9k/ar9003_hw.c:1147 
Message-Id: <E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com>
Date:   Wed, 22 Mar 2023 14:57:06 -0500
To:     linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am receiving a console error message from this driver that appears to =
be in the following function.  In this function, the chk_dbg variable is =
32bits and there is logic that seems to attempt to select from 1 of 2 =
different 32bit values to get a 64bit wide mask value into chk_dbg from =
dma_dbg_4 or dmc_dbg_5.

The problem is that the (5*i) shift count should be have i adjusted by =
the 6 limit used to make the check for which dma_dbg_[45] value =
selected.


static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
{
	u32 dma_dbg_4, dma_dbg_5, dma_dbg_6, chk_dbg;
	u8 dcu_chain_state, dcu_complete_state;
	bool dcu_wait_frdone =3D false;
	unsigned long chk_dcu =3D 0;
	unsigned int i =3D 0;
	dma_dbg_4 =3D REG_READ(ah, AR_DMADBG_4);
	dma_dbg_5 =3D REG_READ(ah, AR_DMADBG_5);
	dma_dbg_6 =3D REG_READ(ah, AR_DMADBG_6);
	dcu_complete_state =3D dma_dbg_6 & 0x3;
	if (dcu_complete_state !=3D 0x1)
		goto exit;
	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
		if (i < 6)
			chk_dbg =3D dma_dbg_4;
		else
			chk_dbg =3D dma_dbg_5;
		dcu_chain_state =3D (chk_dbg >> (5 * i)) & 0x1f;
		if (dcu_chain_state =3D=3D 0x6) {
			dcu_wait_frdone =3D true;
			chk_dcu |=3D BIT(i);
		}
	}
	if ((dcu_complete_state =3D=3D 0x1) && dcu_wait_frdone) {
		for_each_set_bit(i, &chk_dcu, ATH9K_NUM_TX_QUEUES) {
			if (ath9k_hw_verify_hang(ah, i))
				return true;
		}
	}
exit:
	return false;
}

The for loop seems to need to look like the following:

	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
               int off=3Di;
		if (i < 6) {
			chk_dbg =3D dma_dbg_4;
		} else {
			chk_dbg =3D dma_dbg_5;
                       off =3D i - 6;
               }
		dcu_chain_state =3D (chk_dbg >> (5 * off)) & 0x1f;
		if (dcu_chain_state =3D=3D 0x6) {
			dcu_wait_frdone =3D true;
			chk_dcu |=3D BIT(i);
		}
	}

it would be best to have a constant declared that would be based on =
ATH9K_NUM_TX_QUEUES and the magical 32bits of space the declarations =
limit the calculations to.
it seem that the mask of 0x1f suggests that there are 5 bits per queue.  =
So there would be 2 bits left in dma_dbg_4 potentially, but the logic =
suggests that there are simply 6 groups of 5 bits in each of the =
registers without there being a split of the value across the 32-bit =
boundary.

Gregg Wonderly=
