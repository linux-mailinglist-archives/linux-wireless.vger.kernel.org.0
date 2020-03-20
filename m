Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8818C4E6
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 02:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCTBst (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 21:48:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43455 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTBss (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 21:48:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id x18so5356244qki.10
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2020 18:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8n9ElUJ9p8MP3aLBlT0Sotmuxz3/XMP57lyClGar+qk=;
        b=Cc2Rh7o4vqvlaBll9kC9/zX8Ic76IxTfB+RGR3rXVqro+54P1Fg5ZJ6LLjihxWlork
         y975jzznkD41pPD27mEASmw7R0tSzWWmTECKxbVHK+ukWGlHu0YrvzdsSr+oEOizJ7dZ
         NiT2PKe4C4gymfflImTzl+CWgmnozioNFpdxGlNluLFvN7UXGuHItd0tmunnO8Cemp9P
         qu+McKEQNEkDlnFURJ/w2TC5NtNbT/FyqfkpIfVeUE9VRNKUmXEpA47lCO30+iOAAsZZ
         gIO3RLXWXWHoW58xmqSE7OhtCAPLqXO9RYlMx0WzlGW3OlNKpj9GxAjiDlZpy6TnH4PX
         7Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8n9ElUJ9p8MP3aLBlT0Sotmuxz3/XMP57lyClGar+qk=;
        b=efkA8W8EXSyDPLNNSbSW+VO4jyKXZs2fctCMA5WxrgEtlrrpL0SAzDWJzR/BUfwjOm
         yhbJkY1qbDHi8yxxuSw4KCCr0ZWToa3Zyl454ebmpFymvSGRwE2y6A/ASBnn+INRohon
         lD5B49xG4h6IDi8KWMWUWVytRgEhJzjyH7h2we1Ba/6Ydppu8h7oQzHSDPIuFUzTrtwX
         HG7spkGgPxKHunffa0vybwqVv3+NoLz2EVtuSaZGDxa9nARljkbFnTdlTCxPpVRPQBGB
         WfPsFlEGy0t4PaHJGFoGbFZNpOhPhMmVU35JbHtHje04yeu9/1d3OEIwB6831KAwM495
         1TNg==
X-Gm-Message-State: ANhLgQ1XlOpk/GMiaaXpbe2FeNLot4netN1GlxvD/H1EhtDmnEP1k3Q7
        XmiWUB3q/u8++W4IiWkz2V4=
X-Google-Smtp-Source: ADFU+vuhJWPYkbmeE2JNiLsPHXKLoVcI6/3gZKjgGXVYR1L1WKUvSegDXMWo1QGIT79judExr4KWkg==
X-Received: by 2002:a37:844:: with SMTP id 65mr5566510qki.15.1584668925703;
        Thu, 19 Mar 2020 18:48:45 -0700 (PDT)
Received: from yow-masselst-lx1.corp.ad.wrs.com (198-84-181-245.cpe.teksavvy.com. [198.84.181.245])
        by smtp.gmail.com with ESMTPSA id u51sm3351487qth.46.2020.03.19.18.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:48:45 -0700 (PDT)
From:   Mark Asselstine <mark.asselstine@windriver.com>
To:     luciano.coelho@intel.com, linuxwifi@intel.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] iwlwifi: Avoid use of non-existent queues
Date:   Thu, 19 Mar 2020 21:48:39 -0400
Message-Id: <20200320014839.4864-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mark Asselstine <asselsm@gmail.com>

In iwl_pcie_tx_alloc() we only allocate 'num_of_queues' queues to
iwl_trans_pcie.txq[] yet queue_info[] always has IWL_MAX_HW_QUEUES
(ie. 32) entries. This gives us a range of queues from 0 to 31,
however, on some devices we have a num_of_queues of 31 or even 20,
thus a range of 0 to num_of_queues - 1 (or 0 - 30 on 8000 series
devices).

We need to therefor make some of the entries in queue_info[]
unavailable to functions like iwl_mvm_find_free_queue() which
otherwise will return invalid queue indexes.

Without this we get the following Oops:

  kernel: BUG: kernel NULL pointer dereference, address: 00000000000000d8
  kernel: #PF: supervisor write access in kernel mode
  kernel: #PF: error_code(0x0002) - not-present page
  kernel: PGD 0 P4D 0
  kernel: Oops: 0002 [#1] SMP PTI
  kernel: CPU: 0 PID: 2086 Comm: kworker/0:0 Not tainted 5.6.0-0.rc4.git0.1.fc33.x86_64+debug #1
  kernel: Hardware name: LENOVO 10A8S08P00/SHARKBAY, BIOS FBKTDBAUS 12/24/2019
  kernel: Workqueue: events iwl_mvm_add_new_dqa_stream_wk [iwlmvm]
  kernel: RIP: 0010:iwl_trans_pcie_txq_enable+0x4d/0x460 [iwlwifi]
  kernel: Code: bc c7 80 19 00 00 66 89 14 24 f0 48 0f ab 87 80 29 00 00 73 0d 80 3d af 37
  04 00 00 0f 84 c6 03 00 00 44 89 c7 e8 03 42 b0 d0 <49> 89 87 d8 00 00 00 4d 85 f6 0f 84
  d1 02 00 00 41 0f b6 06 89 44
  kernel: RSP: 0018:ffffac44c081fd08 EFLAGS: 00010202
  kernel: RAX: 0000000000002710 RBX: 0000000000000000 RCX: 0000000000000000
  kernel: RDX: 3ffffffffffffffe RSI: 000000000000001f RDI: 0000000000002710
  kernel: RBP: ffff8ee008040028 R08: 0000000000002710 R09: 0000000000000001
  kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000001f
  kernel: R13: ffff8ee00567b3e8 R14: 0000000000000000 R15: 0000000000000000
  kernel: FS:  0000000000000000(0000) GS:ffff8ee00e800000(0000) knlGS:0000000000000000
  kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  kernel: CR2: 00000000000000d8 CR3: 0000000040612003 CR4: 00000000001606f0
  kernel: Call Trace:
  kernel:  iwl_mvm_enable_txq+0x1d8/0x2b0 [iwlmvm]
  kernel:  iwl_mvm_add_new_dqa_stream_wk+0x203/0x910 [iwlmvm]
  kernel:  process_one_work+0x25d/0x570
  kernel:  worker_thread+0x55/0x3d0
  kernel:  ? process_one_work+0x570/0x570
  kernel:  kthread+0x120/0x140
  kernel:  ? __kthread_bind_mask+0x60/0x60
  kernel:  ret_from_fork+0x3a/0x50

which logging shows happens when a queue index of 31 (txq_id) is used
for trans_pcie->txq[txq_id].

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=206765
Reported-by: Gabriel Ramirez <gabriello.ramirez@gmail.com>
Signed-off-by: Mark Asselstine <asselsm@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 54c094e88474..bb6234b13014 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -310,7 +310,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	struct iwl_notification_wait alive_wait;
 	struct iwl_mvm_alive_data alive_data = {};
 	const struct fw_img *fw;
-	int ret;
+	int i, ret;
 	enum iwl_ucode_type old_type = mvm->fwrt.cur_fw_img;
 	static const u16 alive_cmd[] = { MVM_ALIVE };
 	bool run_in_rfkill =
@@ -413,6 +413,16 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	mvm->queue_info[IWL_MVM_DQA_CMD_QUEUE].tid_bitmap =
 		BIT(IWL_MAX_TID_COUNT + 2);
 
+	/*
+	 * Similarly prevent use of non-existing queues. The range
+	 * is from 0 - (num_of_queues-1) or 0 - (IWL_MAX_HW_QUEUES-1)
+	 * whichever is smaller. So we need to disable any queues
+	 * from num_of_queues to IWL_MAX_HW_QUEUES.
+	 */
+	for (i = mvm->trans->trans_cfg->base_params->num_of_queues;
+	     i < IWL_MAX_HW_QUEUES; i++)
+		mvm->queue_info[i].tid_bitmap = BIT(IWL_MAX_TID_COUNT + 2);
+
 	set_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	iwl_fw_set_dbg_rec_on(&mvm->fwrt);
-- 
2.20.1

