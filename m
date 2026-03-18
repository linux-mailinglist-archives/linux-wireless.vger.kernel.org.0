Return-Path: <linux-wireless+bounces-33411-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALNaLnDFumk8bwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33411-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 16:32:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D92BE465
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 16:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4075F32F4D0F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21553EE1C9;
	Wed, 18 Mar 2026 15:03:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D23ED10D
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846214; cv=none; b=ZvAP5ElJepFpeK12V+xh35rkS0c12fheqwEbZyhzAjdPWDKTM7DOKML2u3DQ/NIKG+TYUF0kNwbMCm5ZCQhs3yvCXmrRHjA11u+fuBIt6YQrHMmZGGiUuQU8G+iqnIuKDmFrzQc/jQCrcq8l3RU6g8VbRjOTOuq8Cb8nT3iILdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846214; c=relaxed/simple;
	bh=fFbx4L7c5RG8MsSh64xUKulTqmO1Wn4GpSHiz4YrwzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzS9EjKd/HtOY7oaQipdsuvPtOiouylfi/bV1tmYdyC+Hc9rQmnsUJgwlN0vUi5sLdTrwB8EGQd497jWh4O1Ea3C46wgam3EhsvtHPoRtVRVdgqe0YzzwAAK8NQL92Dbd45XosD9NuG9X+Xbm+EpMm9LQjWirLptk7FE0wI+MCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128d2e3082eso151283c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 08:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846209; x=1774451009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LwI56IvSstpXQXaX8+DYC8cYl7ak5TMhpM2nnpgQBwA=;
        b=hsB4j7dn/X5tvDES1xiAxswrMgpNXcZZ2CBvETocMNkXf5f5Yc3C78yrn9reD4ia+/
         HedRtufig9EP99NTA+JFnfLxMNQTofNlzv1lew1irmYv6UjjMpAseE64rInK8NolZMuJ
         SQBWcJxZHR6Ag/pJ5iIrMRCd14EEsJZJrHQR3hxUkpV7fBKS551yNDZJ/QeTQ6gfQsgD
         VXwPREqUCzy0YcNWKsoGR2Wfgq7reIauoeNFL3YgR8hOCgNLYks4R1wkDFYrd+uHu5tk
         2Cch6ZW9HuL3FJm42pr1PQm7FcwRjkR4PvRKvMT2ISiC9/jqXMqSiSQ+pKUlMWFo10DT
         Jxcw==
X-Forwarded-Encrypted: i=1; AJvYcCVXJeST6XTqppMl0s9Cud7z9lDKR0Q4ItadHAgiiH6tBZdH8vndNjqfo53L7kqXkjc0m/oxoE4wGVbfPcwyQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiouAN28v5Z9WZh0hbMxrRGzoa4ndDsiGHayfxEuKtAAvRBT7V
	7NM7Z/HYlrJCIXko6CIbDkZP+EwyPBMSo8qWk3xkBj0Hp4RNrmV2Bis=
X-Gm-Gg: ATEYQzxL+vLZdyQIGV26fofNuBX2h1JRFMxC7JrUJ+qMfhYzUnVSOEhB2NcUvPse9z7
	FFmpU3/RZI5XflWT79UmNIB8TYwNIoiOyxUQg+0Ig3qI0Abz0AzaFtCNcyROPICzhQd3XtJIpAJ
	o8H6YunyN4uAdN5JYltcDfvq3Qfw+ahHdEOk5u5jtY8HToDKe8QmPflhornlcT93y9By5dxiT9E
	iD1LBD3Z95c9ngLtSZmg9rvMhG8qCYs7i397/sxC1F65VkYsr7D68NZOClkc0TkL4pQHR4pBAz6
	3PYhbupm41wg4Lek9PNtH1m51a3zaj3Nc86ajYxBINC14CMNpkgAjY/0APGcJ4y+nPlpydXPxYm
	um9nvt7DkU1qAHUShro80+LxjKxm2CImUAMFkEwLgMqZ/zlOBNzBIgcI9cKGF3KfyO0Fj2klEVs
	KmmOFAFRG3bFehFIupQndITYP4ppzW7ytaVQ3chcOKgg3e5aFYPFdlRCyUfOJimIO9Dq+2shRLf
	EuyL9tQnHC8xi6+Jw==
X-Received: by 2002:a05:7022:43aa:b0:11b:c1ab:bdd4 with SMTP id a92af1059eb24-129a70eab62mr1700585c88.38.1773846208379;
        Wed, 18 Mar 2026 08:03:28 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129a7256263sm3541023c88.4.2026.03.18.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:27 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 13/13] selftests: net: add team_bridge_macvlan rx_mode test
Date: Wed, 18 Mar 2026 08:03:05 -0700
Message-ID: <20260318150305.123900-14-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33411-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-wireless@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.360];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 5C3D92BE465
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test that exercises the ndo_change_rx_flags path through a
macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
under addr_list_lock which flips promiscuity on the lower device.
With the new work queue approach, this must not deadlock.

Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/config       |  1 +
 tools/testing/selftests/net/rtnetlink.sh | 44 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 2a390cae41bf..94d722770420 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -101,6 +101,7 @@ CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_TEAM=y
 CONFIG_NET_VRF=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_OVS=y
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 5a5ff88321d5..c499953d4885 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -23,6 +23,7 @@ ALL_TESTS="
 	kci_test_encap
 	kci_test_macsec
 	kci_test_macsec_vlan
+	kci_test_team_bridge_macvlan
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -636,6 +637,49 @@ kci_test_macsec_vlan()
 	end_test "PASS: macsec_vlan"
 }
 
+# Test ndo_change_rx_flags call from dev_uc_add under addr_list_lock spinlock.
+# When we are flipping the promisc, make sure it runs on the work queue.
+#
+# https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
+# With (more conventional) macvlan instead of macsec.
+# macvlan -> bridge -> team -> dummy
+kci_test_team_bridge_macvlan()
+{
+	local vlan="test_macv1"
+	local bridge="test_br1"
+	local team="test_team1"
+	local dummy="test_dummy1"
+	local ret=0
+
+	run_cmd ip link add $team type team
+	if [ $ret -ne 0 ]; then
+		end_test "SKIP: team_bridge_macvlan: can't add team interface"
+		return $ksft_skip
+	fi
+
+	run_cmd ip link add $dummy type dummy
+	run_cmd ip link set $dummy master $team
+	run_cmd ip link set $team up
+	run_cmd ip link add $bridge type bridge vlan_filtering 1
+	run_cmd ip link set $bridge up
+	run_cmd ip link set $team master $bridge
+	run_cmd ip link add link $bridge name $vlan \
+		address 00:aa:bb:cc:dd:ee type macvlan mode bridge
+	run_cmd ip link set $vlan up
+
+	run_cmd ip link del $vlan
+	run_cmd ip link del $bridge
+	run_cmd ip link del $team
+	run_cmd ip link del $dummy
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: team_bridge_macvlan"
+		return 1
+	fi
+
+	end_test "PASS: team_bridge_macvlan"
+}
+
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
-- 
2.53.0


