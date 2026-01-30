Return-Path: <linux-wireless+bounces-31341-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O9kJcf4e2n4JgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31341-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 01:18:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7308B5D9D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 01:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86DE8300463B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 00:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6BF26B973;
	Fri, 30 Jan 2026 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="bOhynsEt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072B1F5437
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732289; cv=none; b=A0MiZ5zmRyuXpKnQaYvvBFRaT7l239o2iBvfaWDJQnr3GLtLzkriacbIWYCr36YI1NUiBTJXetkCgY0swSyrVjZvPYQKO27wYXqmpQOjOyA/A9NSOClNyRHIxBkU3X9IU+fJp7UiVJ3QBoAfGDBB/FTEUVnPo0WLFDq0eHIKwF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732289; c=relaxed/simple;
	bh=MvPl1JMjtETL/I0RaJtTpI+3Rk3FqCQcRid8Ng2OyGs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dDxvCHV6XDmkSVB7oPZn9wmPrRmWTMtTkg3CSrxEyVeMlVluuQbo7L1Gk/BpCXRGpbP2L53GEjAO2bpphkHItWdTqGGKxBEC5SWIx8+hWHx7tFan6qXbEyezxsIil7RRWkVqTZD//hbuhsHLlr2Afwej3v6MbEg3sPjPfL26Nkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=bOhynsEt; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7C3B02BE02A
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 00:18:07 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 22B3BA80079;
	Fri, 30 Jan 2026 00:17:58 +0000 (UTC)
Received: from [192.168.101.245] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0C94A13C2B0;
	Thu, 29 Jan 2026 16:17:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0C94A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1769732275;
	bh=MvPl1JMjtETL/I0RaJtTpI+3Rk3FqCQcRid8Ng2OyGs=;
	h=Date:To:Cc:From:Subject:From;
	b=bOhynsEtTaVyGsKxterg8E1JWDYzQus4M35T4rkAJV10PqyFOCScf74pj0VTtXizC
	 xl3vqylZTM3WVu4rAIBe+Ns3RVFIeCvQssJdy96hqiCAnZNZx7NayyrcuUA0wgoDoC
	 +TOVHLCM92kTNN1GK3zorwc2Ud0XHKHZ/b3ly7AQ=
Message-ID: <3f4a9e23-8475-4566-93ee-75a22d9a05c5@candelatech.com>
Date: Thu, 29 Jan 2026 16:17:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>
Cc: linux-wireless@vger.kernel.org, Ben Greear <greearb@candelatech.com>
From: Rory Little <rory@candelatech.com>
Subject: [BUG] MT7996 does not send TXFREE for certain sent frames
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1769732278-EruSZcFgb8E8
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1769732278;EruSZcFgb8E8;<rory@candelatech.com>;048221b4cf8c1c34f5a46475babbf59f
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31341-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rory@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7308B5D9D
X-Rspamd-Action: no action

Hello all,

When transmitting to a specific AP, I have noticed that traffic on all 
but one station stalls after a short period. After some poking at the 
problem, I determined the issue to be that TXFREE messages were not 
reporting freed MSDUs for the 'stalled' stations until every other MSDU 
had been handled. These unfreed tokens seem to consistently be from WCID 
!= 1. If there is a consistent Tx stream from WCID 1, this can cause 
those MSDUs to stay unfreed indefinitely. I am not observing any 
reported retries or Tx failures for these blocked MSDUs, and they appear 
to be transmitted soon after the initial DMA mapping.

We are using the below diff to mitigate the issue, by blocking transmit 
when specific txwi's are held by the NIC for too long. However, this 
solution reduces the throughput of the interfaces, and probably isn't 
viable for the main driver.

One last piece of information, for what its worth, is that this issue 
was not triggering in older (pre-6.12) kernels due to an issue in 
calculating EHT airtime in mac80211. It seems that TXQs regularly 
failing the airtime fairness check helped to mitigate this issue. 
Whether it was due to the reduced throughput, or due to preventing frame 
aggregation, I can't say.

Please let me know if you would like any further information regarding 
this problem.

- Rory

--

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c 
b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d0c522909e98..486145e51064 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -724,6 +724,8 @@ mt76_alloc_device(struct device *pdev, unsigned int 
size,

         INIT_LIST_HEAD(&dev->txwi_cache);
         INIT_LIST_HEAD(&dev->rxwi_cache);
+       INIT_LIST_HEAD(&dev->token_queue);
+       dev->token_queue_tail = &dev->token_queue;
         dev->token_size = dev->drv->token_size;
         INIT_DELAYED_WORK(&dev->scan_work, mt76_scan_work);

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h 
b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5e68efc367fc..c57827fc51fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -449,6 +449,8 @@ struct mt76_txwi_cache {
                 void *ptr;
         };

+       unsigned long jiffies;
+
         u8 qid;
  };

@@ -959,6 +961,8 @@ struct mt76_dev {

         spinlock_t token_lock;
         struct idr token;
+       struct list_head token_queue;
+       struct list_head *token_queue_tail;
         u16 wed_token_count;
         u16 token_count;
         u16 token_start;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c 
b/drivers/net/wireless/mediatek/mt76/tx.c
index 9ec6d0b53a84..495a5c4f931e 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -5,6 +5,11 @@

  #include "mt76.h"

+static unsigned long tx_wait_thresh_ms = 100;
+module_param_named(tx_wait_thresh_ms, tx_wait_thresh_ms, ulong, 0644);
+MODULE_PARM_DESC(tx_wait_thresh_ms, "Time to wait for TXFREE before 
flushing the tx queue.\n"
+                                   "0 to disable this behavior.");
+
  static int
  mt76_txq_get_qid(struct ieee80211_txq *txq)
  {
@@ -850,9 +855,15 @@ int mt76_token_consume(struct mt76_dev *dev, struct 
mt76_txwi_cache **ptxwi)
         token = idr_alloc(&dev->token, *ptxwi, dev->token_start,
                           dev->token_start + dev->token_size,
                           GFP_ATOMIC);
-       if (token >= dev->token_start)
+       if (token >= dev->token_start) {
                 dev->token_count++;

+               list_add(&(*ptxwi)->list, dev->token_queue_tail);
+               dev->token_queue_tail = &(*ptxwi)->list;
+
+               (*ptxwi)->jiffies = jiffies;
+       }
+
  #ifdef CONFIG_NET_MEDIATEK_SOC_WED
         if (mtk_wed_device_active(&dev->mmio.wed) &&
             token >= dev->mmio.wed.wlan.token_start)
@@ -889,7 +900,7 @@ EXPORT_SYMBOL_GPL(mt76_rx_token_consume);
  struct mt76_txwi_cache *
  mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
  {
-       struct mt76_txwi_cache *txwi;
+       struct mt76_txwi_cache *txwi, *oldest_txwi;

         spin_lock_bh(&dev->token_lock);

@@ -897,6 +908,10 @@ mt76_token_release(struct mt76_dev *dev, int token, 
bool *wake)
         if (txwi) {
                 dev->token_count--;

+               if (dev->token_queue_tail == &txwi->list)
+                       dev->token_queue_tail = txwi->list.prev;
+               list_del(&txwi->list);
+
  #ifdef CONFIG_NET_MEDIATEK_SOC_WED
                 if (mtk_wed_device_active(&dev->mmio.wed) &&
                     token >= dev->mmio.wed.wlan.token_start &&
@@ -905,8 +920,13 @@ mt76_token_release(struct mt76_dev *dev, int token, 
bool *wake)
  #endif
         }

-       if (dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
-           dev->phy.q_tx[0]->blocked)
+       oldest_txwi = list_first_entry_or_null(&dev->token_queue, struct 
mt76_txwi_cache, list);
+
+       if (tx_wait_thresh_ms && oldest_txwi &&
+           time_is_before_jiffies(oldest_txwi->jiffies + (HZ * 
tx_wait_thresh_ms / 1000)))
+               __mt76_set_tx_blocked(dev, true);
+       else if (dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
+                  dev->phy.q_tx[0]->blocked)
                 *wake = true;

         spin_unlock_bh(&dev->token_lock);


