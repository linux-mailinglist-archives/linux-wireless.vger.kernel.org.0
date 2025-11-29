Return-Path: <linux-wireless+bounces-29425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57719C938F5
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 08:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61DD24E0EE3
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B3626ED40;
	Sat, 29 Nov 2025 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/YUbN1/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D531D8E01;
	Sat, 29 Nov 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764401895; cv=none; b=sBt6yENbnDwoXvhWd5q2rfvTseXcuK9WNJj53ao34YUaTibAUc3D7cWaajvqDpuR663yN35zVmx94sIpmb9yO6QCP+osiO2oH4gdi+XpFYXywWaxNkK6FNkO+t4WAZA4eJExZAINVF+ZgaVLFZCI0v/thnaNbF8FIZqrpeqkyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764401895; c=relaxed/simple;
	bh=fk/caco66O3igrKNlQ3mxN3bf+op87F3ff2K8yUI+44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFx2rvCKa0TnKzrFQZZXqiyjyPVx3vItax+4DE0MnwsF2YlseAKSO0K+/B3MvtGq715dZJHpZzG6e5nR2ZLTNChJMg41ZOU9dxNhZGq5L9cU6gt1cneWR5ECjGdYxSDHT3eHuBic0GR0vaGdsI1JvEbwmmLuScC/qqhfIOPEA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s/YUbN1/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ennie1o1xJgnnw/cnrOFrBsctCEWs8vsBZkb05Z6xak=; b=s/YUbN1/cEXoi7Tixxyfth/VAc
	qtDfCys6PPoYONPxAtPwkxj3AzgXH/0DAxj32hOGMYRJAVnT6UHE5gxSoO9xxnjGdzjjxh1MuRylV
	O/9W0moxd7cM/IsA5EN44A4V+aV6d6bL0bhua4xEtcjQaMQpNeJEsuPXsVOlWEdjkZtj3ljTtk+LY
	z48545EpY4rJwtoLiYa9nRBDsk9Tvv3EEHAboT2a43dqdcA8TqIAYG78DZ6zIXU1t5jnVTZWYa/16
	xKhGEUpnW2nVXnVYlVgfuOxJh5+SP+45qOzAOz4LhRs57pGTXAwd9eVrxC/Epl6g5RNI5S/34m7ZZ
	Q4CoY3mA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPFWu-00000001Ltd-0Yp5;
	Sat, 29 Nov 2025 07:38:04 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: fix/add kernel-doc comments
Date: Fri, 28 Nov 2025 23:38:03 -0800
Message-ID: <20251129073803.1814384-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct or add kernel-doc comments for:
- an enum name typo
- missing struct member comments in struct vif_saved_ie and
  struct brcmf_cfg80211_vif

fixing these warnings:
Warning: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h:195
 Enum value 'BRCMF_VIF_STATUS_EAP_SUCCESS' not described in enum
 'brcmf_vif_status'
Warning: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h:195
 Excess enum value '@BRCMF_VIF_STATUS_EAP_SUCCUSS' description in
 'brcmf_vif_status'
Warning: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h:220
 struct member 'assoc_req_ie' not described in 'vif_saved_ie'
Warning: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h:220
 struct member 'assoc_req_ie_len' not described in 'vif_saved_ie'
Warning: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h:255
 struct member 'saved_ie' not described in 'brcmf_cfg80211_vif'
Warning: drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h:255
 struct member 'is_11d' not described in 'brcmf_cfg80211_vif'

kernel-doc warnings for missing struct member descriptions in struct
brcmf_cfg80211_info and struct brcmf_cfg80211_profile are still present.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-next-20251128.orig/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ linux-next-20251128/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -182,7 +182,7 @@ struct brcmf_cfg80211_profile {
  * @BRCMF_VIF_STATUS_CONNECTED: connected/joined successfully.
  * @BRCMF_VIF_STATUS_DISCONNECTING: disconnect/disable in progress.
  * @BRCMF_VIF_STATUS_AP_CREATED: AP operation started.
- * @BRCMF_VIF_STATUS_EAP_SUCCUSS: EAPOL handshake successful.
+ * @BRCMF_VIF_STATUS_EAP_SUCCESS: EAPOL handshake successful.
  * @BRCMF_VIF_STATUS_ASSOC_SUCCESS: successful SET_SSID received.
  */
 enum brcmf_vif_status {
@@ -201,10 +201,12 @@ enum brcmf_vif_status {
  * @probe_req_ie: IE info for probe request.
  * @probe_res_ie: IE info for probe response.
  * @beacon_ie: IE info for beacon frame.
+ * @assoc_req_ie: IE info for association request frame.
  * @assoc_res_ie: IE info for association response frame.
  * @probe_req_ie_len: IE info length for probe request.
  * @probe_res_ie_len: IE info length for probe response.
  * @beacon_ie_len: IE info length for beacon frame.
+ * @assoc_req_ie_len: IE info length for association request frame.
  * @assoc_res_ie_len: IE info length for association response frame.
  */
 struct vif_saved_ie {
@@ -227,12 +229,14 @@ struct vif_saved_ie {
  * @wdev: wireless device.
  * @profile: profile information.
  * @sme_state: SME state using enum brcmf_vif_status bits.
+ * @saved_ie: saved IE info for a vif.
  * @list: linked list.
  * @mgmt_tx: completion for management frame transmit.
  * @mgmt_tx_status: status of last management frame sent to firmware.
  * @mgmt_tx_id:
  * @mgmt_rx_reg: registered rx mgmt frame types.
  * @mbss: Multiple BSS type, set if not first AP (not relevant for P2P).
+ * @is_11d: beacon contains country IE, enable regulatory 802.11d support
  * @cqm_rssi_low: Lower RSSI limit for CQM monitoring
  * @cqm_rssi_high: Upper RSSI limit for CQM monitoring
  * @cqm_rssi_last: Last RSSI reading for CQM monitoring

