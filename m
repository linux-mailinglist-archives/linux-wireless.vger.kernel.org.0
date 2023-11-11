Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA497E8D24
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKKWfM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Nov 2023 17:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKWfM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Nov 2023 17:35:12 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D5D8
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 14:35:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507c5249d55so4865673e87.3
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 14:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699742105; x=1700346905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rbXWlt5cik6T4Nfiz7G6ByZ5gaZurqr/SDQtOMyfIiw=;
        b=dE3Wl1X3oqcvIYU0SUcrZPwxJaEY7POMIOGBAU+SmDOiSEA4tYXn/BaeI1TnGPsS4x
         9feD/D+q5JYLyhlvmPl2/xYN4niuH3DbGBNMYsTRMMCVCWfdFCILS2RgfDFJ/xIcg+ww
         dgH7tpQo7XbcdRQasYnh2/4sQc5xxXf0dBo+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699742105; x=1700346905;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbXWlt5cik6T4Nfiz7G6ByZ5gaZurqr/SDQtOMyfIiw=;
        b=unq1QEzdfsuOxhgAgS1C2Z+KljVur0yHr5uBvgt/PxBZ71S+DG7Xd0Bzp7EtX5W4Z7
         rns8dhaaCKcLo3rN7paga/GmfrwdLx3xNFzrbXUrNCLJ/3sfmW6nD6kfKEN9tIb97M3k
         0D2mquMnJiXkI2e7bvoLhxDToAHD4aVJSAPyVCH3ZaRDmHNe7+txKCq3Vlqwb72IIyHH
         0RHoxvOvXkWcmhSEmcoZzdshZ35XkX2DG5veniYo8NUmmBCSkDVq31ksNY6DTB79hNlR
         JbipB2O3AuGt3N4mGsQv+wPK9Sg+TgoXVSRmbL7Q3u8l/QzlSYdYrgeaeWfgnlRsnh2W
         3XgA==
X-Gm-Message-State: AOJu0Yx/cDu/U6kJFqQ9dCBMrkjttPkkr4Q8N11+avVi8aKLJBVpka2s
        o0U7vXM8yqEnezDqfASZl9nNJMGiWpSq51ibMaTF2Q==
X-Google-Smtp-Source: AGHT+IF7NzIOdygua437IXQ9/jt+vx2Pw2bE+rBuuon4B7O5CCAvPAIhsCJXNIyC2ltvuxT+39Js5g==
X-Received: by 2002:a19:a40a:0:b0:507:9640:f256 with SMTP id q10-20020a19a40a000000b005079640f256mr1797806lfc.36.1699742105146;
        Sat, 11 Nov 2023 14:35:05 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id dw24-20020a0565122c9800b005007e7211f7sm412825lfb.21.2023.11.11.14.35.04
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 14:35:04 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5099184f8a3so3778060e87.2
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 14:35:04 -0800 (PST)
X-Received: by 2002:a05:6512:73:b0:507:a5e2:7c57 with SMTP id
 i19-20020a056512007300b00507a5e27c57mr1822529lfo.18.1699742104130; Sat, 11
 Nov 2023 14:35:04 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Nov 2023 14:34:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wix6kqQ5vHZXjOPpZBfM7mMm9bBZxi2Jh7XnaKCqVf94w@mail.gmail.com>
Message-ID: <CAHk-=wix6kqQ5vHZXjOPpZBfM7mMm9bBZxi2Jh7XnaKCqVf94w@mail.gmail.com>
Subject: New iwlwifi warning
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I only noticed now, because it doesn't cause any issues, but that may
be because this only happens on my desktop, and I don't actually use
the wireless there...

The WARN_ON in iwl_trans_configure() has started triggering as of this
merge window:

        WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg));

and causes the appended warning at bootup.

Comments? Anything in particular you need from me for debugging?

                Linus

---

    WARNING: CPU: 3 PID: 2060 at
drivers/net/wireless/intel/iwlwifi/mvm/../iwl-trans.h:1158
iwl_op_mode_mvm_start+0x969/0x970 [iwlmvm]
    Modules linked in: iwlmvm(+) mac80211 libarc4 snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg snd_usb_audio(+) btusb snd_hda_codec
btrtl btintel btbcm iwlwifi ...
    CPU: 3 PID: 2060 Comm: modprobe Not tainted 6.6.0-16167-g045c47737fc1 #19
    Hardware name: Gigabyte Technology Co., Ltd. TRX40 AORUS
MASTER/TRX40 AORUS MASTER, BIOS F5c 03/05/2020
    RIP: 0010:iwl_op_mode_mvm_start+0x969/0x970 [iwlmvm]
    Code: 41 5e 41 5f 5d c3 48 c7 c7 11 89 6f c1 48 c7 c6 97 88 6f c1
e8 58 b0 4e fc b8 01 00 00 00 e9 cd fb ff ff 0f 0b e9 d4 fe ff ff <0f>
0b e9 ac fc ff ff 0f 1f 44 00 00 41 56 53 48 89 fb 4c 8d 77 08
    RSP: 0018:ffffc90003c8b9e8 EFLAGS: 00010286
    RAX: 00000000ffffffff RBX: ffffc90003c8b9f0 RCX: ffffffffc16eef00
    RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffffc16ef590
    RBP: ffff8881146bc028 R08: 0000000000000090 R09: 0000000000000070
    R10: 0000000000000070 R11: 00000000000000ff R12: ffff88815c789fc8
    R13: ffff88811cdaa014 R14: ffff88815c789fc0 R15: ffff8881602d3a40
    FS:  00007efcc530c740(0000) GS:ffff888ffe0c0000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007efcc4d06910 CR3: 000000015a002000 CR4: 0000000000350ef0
    Call Trace:
     <TASK>
     ? __warn+0xc0/0x190
     ? iwl_op_mode_mvm_start+0x969/0x970 [iwlmvm]
     ? report_bug+0x12f/0x1b0
     ? handle_bug+0x3d/0x70
     ? exc_invalid_op+0x16/0x40
     ? asm_exc_invalid_op+0x16/0x20
     ? iwl_op_mode_mvm_start+0x969/0x970 [iwlmvm]
     ? iwl_op_mode_mvm_start+0x614/0x970 [iwlmvm]
     _iwl_op_mode_start+0x5a/0xc0 [iwlwifi]
     iwl_opmode_register+0x88/0xb0 [iwlwifi]
     ? 0xffffffffc0468000
     init_module+0x23/0x1000 [iwlmvm]
     ? 0xffffffffc0468000
     do_one_initcall+0x116/0x2c0
     do_init_module+0xdb/0x2f0
     __x64_sys_finit_module+0x341/0x370
     do_syscall_64+0x40/0xe0
     entry_SYSCALL_64_after_hwframe+0x46/0x4e
