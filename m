Return-Path: <linux-wireless+bounces-13681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F65993E30
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6930A284463
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 05:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637313B2A5;
	Tue,  8 Oct 2024 05:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xnjcu/vF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD6213AA36
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 05:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728363994; cv=none; b=YkzzuJs4W4yzSOund4mrpJzSu2MaAuYPava1PonEAnCtf6QL4vCgQbxqVVcP7/hQW2MdWe1L/lw0TimvPVyy8R/IWuMzKZKv3d511SCQnKUenFwCD+x94Ybn4hb1ZnMgfO3j5onKmr1Gpfl99LsdujLFAphgjCpVGsaQXiEWVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728363994; c=relaxed/simple;
	bh=Ul5807SdYdOPtOowKV4yKt13hMIwRmysNOZWDrnj1MI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlsBWA1AWX3XuOwzt9yuA/odSeREOM7hqc4bTXO8ga5KYqbPQ3VSMmizl6lWztiZ5A9JhB0aWDXOEqoi1GjtqREl5quQ+P8ozrFCyQwkZMz3xpghYvE37kXCLCuRlY3RkMRRCrlfcWWGKEZDCoIkOSemaahSGKrf8YhebR4JYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xnjcu/vF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497LfWWL026282;
	Tue, 8 Oct 2024 05:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jzUBfrDQiCYqbsYmPOdZpgmCmve0rFWdG0fSJsJ8AFc=; b=Xnjcu/vF7+eCw8SG
	yJ0j0JHad0cUYLpficDfIEKHqXxiS2J8bnlYq4vtT7i6t+PcAS5qLIkZnUKqFWeo
	BzgQ7H5XtziP6NhFwLOU6P4np66D/58zjjILuMZkmWJtqvpyTbljDtWWj3+MsBUd
	2Z99FL3r1EVB/Xevg2xAGTkuZ8UiE1xw/4b2B1RseVOyi1BD1X2kL6tFPh5FV/pv
	DcqVvRvW0OrDkug1lza0x9H80X1EPQ8EXXOyLeDSvaTtoPeMizwMz9diJEKvTag2
	zJp8Z1uJXUKhk/lOe+zRMiY1QEYRWPGKZZBM0QVWXeXaiKGRUhEJH/Pf9drdL6oQ
	eiG1gg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424kaesdbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 05:06:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49856Qkv008759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 05:06:26 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Oct 2024 22:06:25 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 2/2] iw: add output for wiphy interface combinations
Date: Tue, 8 Oct 2024 10:36:07 +0530
Message-ID: <20241008050607.1113396-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008050607.1113396-1-quic_adisi@quicinc.com>
References: <20241008050607.1113396-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2aLx0PYwJskzY6TqHY-nWFDHp5GhT7w_
X-Proofpoint-GUID: 2aLx0PYwJskzY6TqHY-nWFDHp5GhT7w_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080031

When multiple hardwares are grouped under a wiphy, the information about it
is advertised via NL80211_ATTR_WIPHY_RADIOS and
NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS attributes. Add support to parse
and display the information in info command.

Sample output with hwsim radio
(insmod mac80211_hwsim.ko radios=1 mlo=1 multi_radio=1):
$ iw phy0 info
  ....
          valid interface combinations:
                 * #{ IBSS } <= 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <= 2048, #{ P2P-device } <= 1,
                   total <= 2050, #channels <= 1, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 160 MHz, 5 MHz, 10 MHz }
  ....
          Supported wiphy radios:
                * Idx 0:
                        Frequency Range:  2402 MHz - 2494 MHz
                        Radio's valid interface combinations:
                                 * #{ IBSS } <= 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <= 2048, #{ P2P-device } <= 1,
                                   total <= 2050, #channels <= 1, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 160 MHz, 5 MHz, 10 MHz }

                * Idx 1:
                        Frequency Range:  5170 MHz - 5935 MHz
                        Radio's valid interface combinations:
                                 * #{ IBSS } <= 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <= 2048, #{ P2P-device } <= 1,
                                   total <= 2050, #channels <= 1, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 160 MHz, 5 MHz, 10 MHz }

                * Idx 2:
                        Frequency Range:  5945 MHz - 7125 MHz
                        Radio's valid interface combinations:
                                 * #{ IBSS } <= 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <= 2048, #{ P2P-device } <= 1,
                                   total <= 2050, #channels <= 1, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 160 MHz, 5 MHz, 10 MHz }

                * Idx 3:
                        Frequency Range:  892 MHz - 937 MHz
                        Radio's valid interface combinations:
                                 * #{ IBSS } <= 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <= 2048, #{ P2P-device } <= 1,
                                   total <= 2050, #channels <= 1, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 160 MHz, 5 MHz, 10 MHz }

        Globally valid interface combinations:
                 * #{ IBSS } <= 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <= 2048, #{ P2P-device } <= 1,
                   total <= 2050, #channels <= 4

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 info.c | 219 ++++++++++++++++++++++++++++++++++++---------------------
 iw.h   |   7 ++
 reg.c  |   7 --
 3 files changed, 147 insertions(+), 86 deletions(-)

diff --git a/info.c b/info.c
index c5e863f1d6b8..986eaa66b3b7 100644
--- a/info.c
+++ b/info.c
@@ -295,6 +295,85 @@ static void print_pmsr_capabilities(struct nlattr *pmsr_capa)
 	}
 }
 
+static void print_interface_combination(struct nlattr *nla, bool *have_combinations,
+					const char *indent, const char *tag)
+{
+	static struct nla_policy iface_combination_policy[NUM_NL80211_IFACE_COMB] = {
+		[NL80211_IFACE_COMB_LIMITS] = { .type = NLA_NESTED },
+		[NL80211_IFACE_COMB_MAXNUM] = { .type = NLA_U32 },
+		[NL80211_IFACE_COMB_STA_AP_BI_MATCH] = { .type = NLA_FLAG },
+		[NL80211_IFACE_COMB_NUM_CHANNELS] = { .type = NLA_U32 },
+		[NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS] = { .type = NLA_U32 },
+	};
+	struct nlattr *tb_comb[NUM_NL80211_IFACE_COMB];
+	static struct nla_policy iface_limit_policy[NUM_NL80211_IFACE_LIMIT] = {
+		[NL80211_IFACE_LIMIT_TYPES] = { .type = NLA_NESTED },
+		[NL80211_IFACE_LIMIT_MAX] = { .type = NLA_U32 },
+	};
+	struct nlattr *tb_limit[NUM_NL80211_IFACE_LIMIT];
+	struct nlattr *nl_limit;
+	int err, rem_limit;
+	bool comma = false;
+
+	if (!(*have_combinations)) {
+		printf("%s%svalid interface combinations:\n", indent, tag);
+		*have_combinations = true;
+	}
+
+	printf("%s\t * ", indent);
+
+	err = nla_parse_nested(tb_comb, MAX_NL80211_IFACE_COMB,
+			       nla, iface_combination_policy);
+	if (err || !tb_comb[NL80211_IFACE_COMB_LIMITS] ||
+	    !tb_comb[NL80211_IFACE_COMB_MAXNUM] ||
+	    !tb_comb[NL80211_IFACE_COMB_NUM_CHANNELS]) {
+		printf(" <failed to parse>\n");
+		return;
+	}
+
+	nla_for_each_nested(nl_limit, tb_comb[NL80211_IFACE_COMB_LIMITS], rem_limit) {
+		err = nla_parse_nested(tb_limit, MAX_NL80211_IFACE_LIMIT,
+				       nl_limit, iface_limit_policy);
+		if (err || !tb_limit[NL80211_IFACE_LIMIT_TYPES]) {
+			printf("<failed to parse>\n");
+			return;
+		}
+
+		if (comma)
+			printf(", ");
+		comma = true;
+		printf("#{ ");
+		print_iftype_line(tb_limit[NL80211_IFACE_LIMIT_TYPES]);
+		printf(" } <= %u", nla_get_u32(tb_limit[NL80211_IFACE_LIMIT_MAX]));
+	}
+	printf(",\n%s\t   ", indent);
+
+	printf("total <= %d, #channels <= %d%s",
+		nla_get_u32(tb_comb[NL80211_IFACE_COMB_MAXNUM]),
+		nla_get_u32(tb_comb[NL80211_IFACE_COMB_NUM_CHANNELS]),
+		tb_comb[NL80211_IFACE_COMB_STA_AP_BI_MATCH] ?
+			", STA/AP BI must match" : "");
+	if (tb_comb[NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS]) {
+		unsigned long widths = nla_get_u32(tb_comb[NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS]);
+
+		if (widths) {
+			int width;
+			bool first = true;
+
+			printf(", radar detect widths: {");
+			for (width = 0; width < 32; width++)
+				if (widths & (1 << width)) {
+					printf("%s %s",
+					       first ? "":",",
+					       channel_width_name(width));
+					first = false;
+				}
+			printf(" }\n");
+		}
+	}
+	printf("\n");
+}
+
 static int print_phy_handler(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *tb_msg[NL80211_ATTR_MAX + 1];
@@ -560,88 +639,12 @@ next:
 				  "\t\t", tb_msg[NL80211_ATTR_SOFTWARE_IFTYPES]);
 
 	if (tb_msg[NL80211_ATTR_INTERFACE_COMBINATIONS]) {
+		bool have_combinations = false;
 		struct nlattr *nl_combi;
 		int rem_combi;
-		bool have_combinations = false;
-
-		nla_for_each_nested(nl_combi, tb_msg[NL80211_ATTR_INTERFACE_COMBINATIONS], rem_combi) {
-			static struct nla_policy iface_combination_policy[NUM_NL80211_IFACE_COMB] = {
-				[NL80211_IFACE_COMB_LIMITS] = { .type = NLA_NESTED },
-				[NL80211_IFACE_COMB_MAXNUM] = { .type = NLA_U32 },
-				[NL80211_IFACE_COMB_STA_AP_BI_MATCH] = { .type = NLA_FLAG },
-				[NL80211_IFACE_COMB_NUM_CHANNELS] = { .type = NLA_U32 },
-				[NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS] = { .type = NLA_U32 },
-			};
-			struct nlattr *tb_comb[NUM_NL80211_IFACE_COMB];
-			static struct nla_policy iface_limit_policy[NUM_NL80211_IFACE_LIMIT] = {
-				[NL80211_IFACE_LIMIT_TYPES] = { .type = NLA_NESTED },
-				[NL80211_IFACE_LIMIT_MAX] = { .type = NLA_U32 },
-			};
-			struct nlattr *tb_limit[NUM_NL80211_IFACE_LIMIT];
-			struct nlattr *nl_limit;
-			int err, rem_limit;
-			bool comma = false;
-
-			if (!have_combinations) {
-				printf("\tvalid interface combinations:\n");
-				have_combinations = true;
-			}
 
-			printf("\t\t * ");
-
-			err = nla_parse_nested(tb_comb, MAX_NL80211_IFACE_COMB,
-					       nl_combi, iface_combination_policy);
-			if (err || !tb_comb[NL80211_IFACE_COMB_LIMITS] ||
-			    !tb_comb[NL80211_IFACE_COMB_MAXNUM] ||
-			    !tb_comb[NL80211_IFACE_COMB_NUM_CHANNELS]) {
-				printf(" <failed to parse>\n");
-				goto broken_combination;
-			}
-
-			nla_for_each_nested(nl_limit, tb_comb[NL80211_IFACE_COMB_LIMITS], rem_limit) {
-				err = nla_parse_nested(tb_limit, MAX_NL80211_IFACE_LIMIT,
-						       nl_limit, iface_limit_policy);
-				if (err || !tb_limit[NL80211_IFACE_LIMIT_TYPES]) {
-					printf("<failed to parse>\n");
-					goto broken_combination;
-				}
-
-				if (comma)
-					printf(", ");
-				comma = true;
-				printf("#{ ");
-				print_iftype_line(tb_limit[NL80211_IFACE_LIMIT_TYPES]);
-				printf(" } <= %u", nla_get_u32(tb_limit[NL80211_IFACE_LIMIT_MAX]));
-			}
-			printf(",\n\t\t   ");
-
-			printf("total <= %d, #channels <= %d%s",
-				nla_get_u32(tb_comb[NL80211_IFACE_COMB_MAXNUM]),
-				nla_get_u32(tb_comb[NL80211_IFACE_COMB_NUM_CHANNELS]),
-				tb_comb[NL80211_IFACE_COMB_STA_AP_BI_MATCH] ?
-					", STA/AP BI must match" : "");
-			if (tb_comb[NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS]) {
-				unsigned long widths = nla_get_u32(tb_comb[NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS]);
-
-				if (widths) {
-					int width;
-					bool first = true;
-
-					printf(", radar detect widths: {");
-					for (width = 0; width < 32; width++)
-						if (widths & (1 << width)) {
-							printf("%s %s",
-							       first ? "":",",
-							       channel_width_name(width));
-							first = false;
-						}
-					printf(" }\n");
-				}
-			}
-			printf("\n");
-broken_combination:
-			;
-		}
+		nla_for_each_nested(nl_combi, tb_msg[NL80211_ATTR_INTERFACE_COMBINATIONS], rem_combi)
+			print_interface_combination(nl_combi, &have_combinations, "\t", "");
 
 		if (!have_combinations)
 			printf("\tinterface combinations are not supported\n");
@@ -885,6 +888,64 @@ broken_combination:
 		printf("\tMaximum associated stations in AP mode: %u\n",
 		       nla_get_u32(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA]));
 
+	if (tb_msg[NL80211_ATTR_WIPHY_RADIOS]) {
+		struct nlattr *radio;
+		int rem_radios;
+
+		printf("\tSupported wiphy radios:\n");
+		nla_for_each_nested(radio, tb_msg[NL80211_ATTR_WIPHY_RADIOS], rem_radios) {
+			bool have_combinations = false;
+			struct nlattr *radio_prop;
+			int rem_radio_prop;
+
+			nla_for_each_nested(radio_prop, radio, rem_radio_prop) {
+				struct nlattr *tb_freq[NL80211_WIPHY_RADIO_FREQ_ATTR_MAX + 1];
+
+				switch (nla_type(radio_prop)) {
+				case NL80211_WIPHY_RADIO_ATTR_INDEX:
+					printf("\t\t* Idx %u:\n", nla_get_u32(radio_prop));
+					break;
+				case NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE:
+					printf("\t\t\tFrequency Range: ");
+
+					nla_parse_nested(tb_freq, NL80211_WIPHY_RADIO_FREQ_ATTR_MAX, radio_prop,
+							 NULL);
+					if (!tb_freq[NL80211_WIPHY_RADIO_FREQ_ATTR_START] ||
+					    !tb_freq[NL80211_WIPHY_RADIO_FREQ_ATTR_END]) {
+						printf("<failed to parse>");
+					} else {
+						printf("%u MHz - %u MHz",
+						       KHZ_TO_MHZ(nla_get_u32(tb_freq[NL80211_WIPHY_RADIO_FREQ_ATTR_START])),
+						       KHZ_TO_MHZ(nla_get_u32(tb_freq[NL80211_WIPHY_RADIO_FREQ_ATTR_END])));
+					}
+					printf("\n");
+					break;
+				case NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION:
+					print_interface_combination(radio_prop, &have_combinations, "\t\t\t",
+								    "Radio's ");
+					if (!have_combinations)
+						printf("\t\t\tRadio level interface combinations are not supported\n");
+					break;
+				default:
+					printf("\t\t\t* <failed to parse>\n");
+				}
+			}
+		}
+	}
+
+	if (tb_msg[NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS]) {
+		bool have_combinations = false;
+		struct nlattr *nl_combi;
+		int rem_combi;
+
+		nla_for_each_nested(nl_combi, tb_msg[NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS], rem_combi)
+			print_interface_combination(nl_combi, &have_combinations, "\t",
+						    "Globally ");
+
+		if (!have_combinations)
+			printf("\tGlobal interface combinations are not supported\n");
+	}
+
 	return NL_SKIP;
 }
 
diff --git a/iw.h b/iw.h
index f416d6df1843..b45e54a8832b 100644
--- a/iw.h
+++ b/iw.h
@@ -47,6 +47,13 @@ enum nlmsgerr_attrs {
 #  define nl_sock nl_handle
 #endif
 
+#define MHZ_TO_KHZ(freq) ((freq) * 1000)
+#define KHZ_TO_MHZ(freq) ((freq) / 1000)
+#define DBI_TO_MBI(gain) ((gain) * 100)
+#define MBI_TO_DBI(gain) ((gain) / 100)
+#define DBM_TO_MBM(gain) ((gain) * 100)
+#define MBM_TO_DBM(gain) ((gain) / 100)
+
 struct nl80211_state {
 	struct nl_sock *nl_sock;
 	int nl80211_id;
diff --git a/reg.c b/reg.c
index 857c995cf635..27899ce859ea 100644
--- a/reg.c
+++ b/reg.c
@@ -13,13 +13,6 @@
 
 SECTION(reg);
 
-#define MHZ_TO_KHZ(freq) ((freq) * 1000)
-#define KHZ_TO_MHZ(freq) ((freq) / 1000)
-#define DBI_TO_MBI(gain) ((gain) * 100)
-#define MBI_TO_DBI(gain) ((gain) / 100)
-#define DBM_TO_MBM(gain) ((gain) * 100)
-#define MBM_TO_DBM(gain) ((gain) / 100)
-
 static bool isalpha_upper(char letter)
 {
 	if (letter >= 65 && letter <= 90)
-- 
2.34.1


