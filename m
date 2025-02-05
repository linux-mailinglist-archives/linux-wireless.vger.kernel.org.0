Return-Path: <linux-wireless+bounces-18477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A2A28039
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077383A712E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D547227B98;
	Wed,  5 Feb 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT5tbY65"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36E1FE479;
	Wed,  5 Feb 2025 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716221; cv=none; b=LRWpdQiO2SFmWxz1JoYwzgrQSqUOJgYR/kPxM3YVoNP97qtJslDA+dZvpI9em89QEpSy7VwkwkO/qvzdW20I3oKiDMrWMnJTIHMnnRh6aoW6zjY9cg7HwqChW3Mt+pFEQWi6KZwNAMrcLjtoNj6uQCTLamBPbzfjM/lmpQOSehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716221; c=relaxed/simple;
	bh=DYdszt71y6WeymCQBtk4lvyx4TCPHkHSFV4UdgUples=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oQzVb3GvwJ+C38oWKfwE/BzvHmvdU8PptL+tIzZZ0TCW+0o/ltPC0q4sW9SMkQkqICdV+I3YIYAMl7lhYodj9TE6jNiY5cvekTmW8ESUSOb1fb8wZcKMhjx7aDRWfoGz88isa6PexMPqxe8d9aTf8anBJS3cjcWg0lFZ0BQpCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT5tbY65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1025CC4CEDF;
	Wed,  5 Feb 2025 00:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738716220;
	bh=DYdszt71y6WeymCQBtk4lvyx4TCPHkHSFV4UdgUples=;
	h=Date:From:To:Cc:Subject:From;
	b=IT5tbY65Vi0gQSafotjimOwjig4H7Ai4+mYmNAFtqjbEBESJt3efkTek1cfsWv1YU
	 641LJHpDZn2RReo00FcSbzE4KFsgFdK8u2HbR97dtZKVobmqj+98O3e4Q/Z9EKUta1
	 EJE72CrlNVSd9n0O2dXuBP2tUvdsshlu18twd5NZn+A/axSGuVn7yD6t8JdjgrgxYp
	 83htpfOjr5+OY+7ieJsDVmZYvr+DlXcp778+1d7zdkgY/Uo2xAgal4/Knx/KBXVdU1
	 maheqOeN4YryPwNYPx0UAm5AVrNfA6zEteXxdZV2RJ8vcbXjVRo5gOcEwVkq32qGQz
	 TiceXpYqVzlYw==
Date: Wed, 5 Feb 2025 11:13:33 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] qtnfmac: Avoid multiple -Wflex-array-member-not-at-end
 warnings
Message-ID: <Z6K0Nd_IprrhS6pn@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of other structs, we use the `__struct_group()` helper to
create a new tagged `struct qlink_tlv_hdr_fixed`. This structure
groups together all the members of the flexible `struct qlink_tlv_hdr`
except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct member currently causing
trouble from `struct qlink_tlv_hdr` to `struct qlink_tlv_hdr_fixed`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that
the memory layout for both the flexible structure and the new tagged
struct is the same after any changes.

This approach avoids having to implement `struct qlink_tlv_hdr_fixed`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

So, with this changes, fix 66 of the following warnings:
drivers/net/wireless/quantenna/qtnfmac/qlink.h:1681:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/quantenna/qtnfmac/qlink.h:1660:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/quantenna/qtnfmac/qlink.h:1646:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/quantenna/qtnfmac/qlink.h:1621:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/quantenna/qtnfmac/qlink.h:1609:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/quantenna/qtnfmac/qlink.h:1570:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../net/wireless/quantenna/qtnfmac/qlink.h    | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
index 674461fa7fb3..eae35b678952 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -1510,10 +1510,15 @@ enum qlink_tlv_id {
 };
 
 struct qlink_tlv_hdr {
-	__le16 type;
-	__le16 len;
+	/* New members MUST be added within the struct_group() macro below. */
+	__struct_group(qlink_tlv_hdr_fixed, __hdr, __packed,
+		__le16 type;
+		__le16 len;
+	);
 	u8 val[];
 } __packed;
+static_assert(offsetof(struct qlink_tlv_hdr, val) == sizeof(struct qlink_tlv_hdr_fixed),
+	      "struct member likely outside of __struct_group()");
 
 struct qlink_iface_limit {
 	__le16 max_num;
@@ -1567,7 +1572,7 @@ enum qlink_reg_rule_flags {
  * @dfs_cac_ms: DFS CAC period.
  */
 struct qlink_tlv_reg_rule {
-	struct qlink_tlv_hdr hdr;
+	struct qlink_tlv_hdr_fixed hdr;
 	__le32 start_freq_khz;
 	__le32 end_freq_khz;
 	__le32 max_bandwidth_khz;
@@ -1606,7 +1611,7 @@ enum qlink_dfs_state {
  * @channel: ieee80211 channel settings.
  */
 struct qlink_tlv_channel {
-	struct qlink_tlv_hdr hdr;
+	struct qlink_tlv_hdr_fixed hdr;
 	struct qlink_channel chan;
 } __packed;
 
@@ -1618,7 +1623,7 @@ struct qlink_tlv_channel {
  * @chan: channel definition data.
  */
 struct qlink_tlv_chandef {
-	struct qlink_tlv_hdr hdr;
+	struct qlink_tlv_hdr_fixed hdr;
 	struct qlink_chandef chdef;
 } __packed;
 
@@ -1643,7 +1648,7 @@ enum qlink_ie_set_type {
  * @ie_data: IEs data.
  */
 struct qlink_tlv_ie_set {
-	struct qlink_tlv_hdr hdr;
+	struct qlink_tlv_hdr_fixed hdr;
 	u8 type;
 	u8 flags;
 	u8 rsvd[2];
@@ -1657,7 +1662,7 @@ struct qlink_tlv_ie_set {
  * @ie_data: IEs data.
  */
 struct qlink_tlv_ext_ie {
-	struct qlink_tlv_hdr hdr;
+	struct qlink_tlv_hdr_fixed hdr;
 	u8 eid_ext;
 	u8 rsvd[3];
 	u8 ie_data[];
@@ -1678,7 +1683,7 @@ struct qlink_sband_iftype_data {
  * @iftype_data: interface type data entries.
  */
 struct qlink_tlv_iftype_data {
-	struct qlink_tlv_hdr hdr;
+	struct qlink_tlv_hdr_fixed hdr;
 	u8 n_iftype_data;
 	u8 rsvd[3];
 	struct qlink_sband_iftype_data iftype_data[];
-- 
2.43.0


