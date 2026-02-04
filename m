Return-Path: <linux-wireless+bounces-31540-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IImkJbxMg2ktlAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31540-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 14:42:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E5E6996
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 14:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BE6230062D7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52824290D;
	Wed,  4 Feb 2026 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Hg5YQLWl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55584245012
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212537; cv=none; b=Eoba3Z8fadVfAyzQ6vJat1LmuHYqBDpWFMUa10/VqMDIjc5C0uHYxnUF65pCz5oqiLbwqy/ZvP/FFuhwxkFcRh8GfxZMzgwCB62gJ8mh6Nd/tEDKXMfBE1x4k+84gaUahgfIlE60LSSuVZG1rVrvwrqyUTt5Y69RAn22bDRDgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212537; c=relaxed/simple;
	bh=tViNZnFeJg0mN32xS1ari3VlSbSD7advUxU6jiWVEI4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dE7AEFpE28udtpL2QvdOUi2Ng+Bq7Nev3FAfinhvCoGXZvWXBT6EnEnwTzMndBecTePWFkW/XjfvATLsLPGkw+vHOzEDmM1pFd9Jknjw2pTEz2fYRfjAlhWyX+ZkUhKu92IHj7SVv7sZkJX5j0X/ltwo31IV7Tgi+VoYZiTerY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Hg5YQLWl; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E765C2CBC86
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 13:42:09 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D9D20C007B;
	Wed,  4 Feb 2026 13:42:01 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.38.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9F0F013C2B0;
	Wed,  4 Feb 2026 05:41:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9F0F013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1770212519;
	bh=tViNZnFeJg0mN32xS1ari3VlSbSD7advUxU6jiWVEI4=;
	h=Date:To:Cc:From:Subject:From;
	b=Hg5YQLWlNwQdV81sblbkfaRQGuTecjd0qb+W+k/4DFSxsNk5d+0wgWQztkJqXtNOT
	 6NpkbgiyQeAoQ7BwzIOZnBVY3EwNV3QqPvG1ke1/U/DOZsRFfWvZKarZm/OYzpIkns
	 /UNR71Oh33IDtZfgWNvr6FCF1qtpmrw8n0ahzRI4=
Message-ID: <ed9ab029-a762-4666-85ed-7a67ec7c1b52@candelatech.com>
Date: Wed, 4 Feb 2026 05:41:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
From: Ben Greear <greearb@candelatech.com>
Subject: iwlwifi: Null deref in iwl_mld_reorder
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1770212522-PKtb-qG79Ucd
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1770212522;PKtb-qG79Ucd;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31540-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 183E5E6996
X-Rspamd-Action: no action

Hello,

While chasing what appears to be a different problem, I started checking for
NULL in iwl_mld_sta_from_mac80211.  That showed a problem in the code below,
where mld_sta is assigned before sta is checked for null.

I guess the compiler optimized this somehow so that crashes are not actually
seen in this particular code path.  Also possible that it is somehow exacerbated
by some local patch in our tree.

But, probably best to assign mld_sta after the NULL sta check.


/* Returns true if the MPDU was buffered\dropped, false if it should be passed
  * to upper layer.
  */
enum iwl_mld_reorder_result
iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
                 int queue, struct ieee80211_sta *sta,
                 struct sk_buff *skb, struct iwl_rx_mpdu_desc *desc)
{
         struct ieee80211_hdr *hdr = (void *)skb_mac_header(skb);
         struct iwl_mld_baid_data *baid_data;
         struct iwl_mld_reorder_buffer *buffer;
         struct iwl_mld_reorder_buf_entry *entries;
         struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);

assignment before checking NULL sta. ^^^

         struct iwl_mld_link_sta *mld_link_sta;
         u32 reorder = le32_to_cpu(desc->reorder_data);
         bool amsdu, last_subframe, is_old_sn, is_dup;
         u8 tid = ieee80211_get_tid(hdr);
         u8 baid;
         u16 nssn, sn;
         u32 sta_mask = 0;
         int index;
         u8 link_id;

         baid = u32_get_bits(reorder, IWL_RX_MPDU_REORDER_BAID_MASK);

         /* This also covers the case of receiving a Block Ack Request
          * outside a BA session; we'll pass it to mac80211 and that
          * then sends a delBA action frame.
          * This also covers pure monitor mode, in which case we won't
          * have any BA sessions.
          */
         if (baid == IWL_RX_REORDER_DATA_INVALID_BAID)
                 return IWL_MLD_PASS_SKB;

         /* no sta yet */
         if (WARN_ONCE(!sta,
                       "Got valid BAID without a valid station assigned\n"))
                 return IWL_MLD_PASS_SKB;

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

