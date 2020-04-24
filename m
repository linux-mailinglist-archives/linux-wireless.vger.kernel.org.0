Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E381B7319
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgDXLae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 07:30:34 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:60842 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbgDXLae (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 07:30:34 -0400
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OBQo8q032588;
        Fri, 24 Apr 2020 05:30:29 -0600
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-00183b01.pphosted.com with ESMTP id 30fxuf1t4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 05:30:29 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFMPs6YAdN2x9GfkkT/5o7098yzrLgCw13y927LX4U1+tYvAHhC2rsfwPPbEvMl03e+Jd5V8EyKcbrsaoxnbVm28mq2m389dCCFukGkcal5azSbqpOACmHkAED8dvdYNZkpYoAkGxgLPWDyMeGd1FAQq8JZXSgXRSeaS0RHHtX0glk4Z0Pq3B3cFsGJJ3KcoLhQiQhCeDhgtNhebB5e38Yj8yL01rwU4gKc/VtupJkcYueQAufLCaEz91mSFYfR9a8f5FSijwoCNl94wuge0BRzrszpFqGQ6iw4x/HVqHKWXmLMMdh5sv0sDBroH+RmxLLuq3CxTRs/UHNUG3DMmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFZu/96ON3IEOx4vzwVz0mo+YAZZYBoqYP8i184h7J0=;
 b=jvtpdzMerpQqGB0z/EIu0AnoHTJIM4Sy2EeZ/IiWxHs/Y4Of7NgdwDdGhsGGpijFchdQjv0JC7bZeMGxC4375Yt8v1DmB6ddfQSRogr5nuPolc3aTK6i0Q34f53pkK1MaOnkm1J2Yt5VbedeEzFl9cM+fAUM1GZ9qz2yS9w37KjQn7PwgMrAWF4gX8e3ViTavhpgQ+f82D3Zr71w8b+dwpFUYfWyrVTwndgWaR0kr7PZ8bGTyss2trlzDUN2Z0JAdvTwFXLNIfNovfcG9JTE+B6vIljt9L/Y5F5wGmqYeoas+VOGoO1cw/3JL2nLxrtBqawlHl3hd51xGGOXkWNtWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFZu/96ON3IEOx4vzwVz0mo+YAZZYBoqYP8i184h7J0=;
 b=BgkeSaVr0s080auQQGX6AIrQOVTgxCHknqnm+SovXXtCrjVAV/gWQDjy1Vq0BVxdoiWVu3TsJ8Amkf21TqPXc3cqKuHGtRSt0DWcNv+Qxj7g3m/kkJDw1dQpN3SW7L02uR6DUqKX2fZlKVpApZsQL6kelbE7ohE1d2FHXKV07qQ=
Received: from CY1PR05MB2650.namprd05.prod.outlook.com
 (2a01:111:e400:c618::11) by CY1PR05MB2489.namprd05.prod.outlook.com
 (2a01:111:e400:c613::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 11:30:27 +0000
Received: from CY1PR05MB2650.namprd05.prod.outlook.com
 ([fe80::7c5e:6652:ca0f:b13d]) by CY1PR05MB2650.namprd05.prod.outlook.com
 ([fe80::7c5e:6652:ca0f:b13d%7]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 11:30:27 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3160.namprd05.prod.outlook.com (2603:10b6:903:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 11:29:21 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 11:29:21 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH v2 5/5] iw: add TID specific configuration command
Date:   Fri, 24 Apr 2020 14:29:05 +0300
Message-ID: <20200424112905.26770-6-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
References: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::28) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by AM0PR01CA0087.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 11:29:20 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64378d33-b0bb-41cc-26aa-08d7e842bbd7
X-MS-TrafficTypeDiagnostic: CY4PR05MB3160:|CY1PR05MB2489:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB3160AA56197FF71BF5311075A3D00@CY4PR05MB3160.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 11:30:26 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR05MB2650.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(396003)(376002)(366004)(346002)(66946007)(4326008)(478600001)(6916009)(66556008)(1076003)(5660300002)(6666004)(54906003)(26005)(316002)(66476007)(36756003)(7696005)(52116002)(86362001)(107886003)(8936002)(81156014)(6486002)(8676002)(103116003)(956004)(186003)(2616005)(2906002)(16526019);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UtuoZnal2YxGpnKQqIVahLd95Y9bYGIQXo+bEi5bDDCr8p2F0xJ2iOK9kb/+vh3gMtgxq245yT2GZ1K2K0AL1KXPwVakeTSV57GJfMMaeVkvyEhFGQiWbu1bLp+t8hongU8fJ+cXbdcKZR4WXDJD2knLq4wErKXvbzUl1CtuC+v330sdSny5evE81hQxq0TjAr1Hzk1xq4+NLGKT9EDMgnFu6DOMr9biYj80+NRCqB9sEeW83YFWIC9AT0CR+uKyD+PmIgw7dh6v7WDFgsFXXtG5LitMDeyAKmA+K2HEx0iavF25ytKFTF+m8ZExWd478dNeWrh3HDz3isug4i+TnGGIlD3R7EhzYvrx0Z0081SPSSPFskaqFHougXnSdbRo3CV/jjYvEWMD4you7D+s3WojBEdd925Jl0S9xf/BolMIDU3TP+/GLuAF9xhAh7W
X-MS-Exchange-AntiSpam-MessageData: 8EYTJpVYOwDGUvjQTsi2zSQC37F0fmDnGy4hGzmaAYbQo6kS7yx3PB7kNqch7g/vYzoCdnTdTTtL8EkJuFyJ/ki7yx80SrasV2DZAGpcU6aS3Wb6Lax7GDsc/6eWvxbGJb0GekDtRiGkaIJdxzoWfw==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64378d33-b0bb-41cc-26aa-08d7e842bbd7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCm3KjBfxpmW9Fd8Lzq93xaycezI+Nym2Cl72rboXUsycYhSRwHqyHezzABcek4kZXxJJDBxEq0yup21YDInXN+immePOjCOuYe3QZFzGaKBkhY59e/a858bzM9VNBfBSHAgj0kxJyU70RjI3Okc6yBAkLBCRRV7+WNLkJaKvN7BAyZjwT5I5iwSfDUpfrgNTb8zupJYNHUTnNXyNpXGjg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 11:30:27.6270
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR05MB2489
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use command NL80211_CMD_SET_TID_CONFIG to perform per-node TID specific
configuration. If peer is not specified, then configuration is applied
to all the peers. Currently kernel supports configuration of the
following parameters:
- short/long retry
- mpdu/msdu aggregation on/off
- rts/cts on/off
- noack on/off

Examples:
Apply configuration for specific peer and TIDs:
$ iw dev wlan0 set tidconf peer 1:2:3:4:5:6 tids 0x3 ampdu off tids 0x2 sretry 10 lretry 100
$ iw dev wlan0 set tidconf peer 1:2:3:4:5:6 tids 0x1 override ampdu off amsdu off

Apply configuration for all peers and all TIDs:
$ iw dev wlan0 set tidconf tids 0xff ampdu off amsdu off sretry 10 lretry 100 noack off

Apply configuration for all peers and specific TIDs:
$ iw dev wlan0 set tidconf peer 0xff:0xff:0xff:0xff:0xff:0xff tids 0x1 ampdu off amsdu off

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 interface.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/interface.c b/interface.c
index 6a44304..df96bed 100644
--- a/interface.c
+++ b/interface.c
@@ -727,3 +727,232 @@ COMMAND(switch, freq,
 	"Switch the operating channel by sending a channel switch announcement (CSA).");
 COMMAND(switch, channel, "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz] [beacons <count>] [block-tx]",
 	NL80211_CMD_CHANNEL_SWITCH, 0, CIB_NETDEV, handle_chan, NULL);
+
+
+static int toggle_tid_param(const char *argv0, const char *argv1,
+			    struct nl_msg *msg, uint32_t attr)
+{
+	uint8_t val;
+
+	if (strcmp(argv1, "on") == 0) {
+		val = NL80211_TID_CONFIG_ENABLE;
+	} else if (strcmp(argv1, "off") == 0) {
+		val = NL80211_TID_CONFIG_DISABLE;
+	} else {
+		fprintf(stderr, "Invalid %s parameter: %s\n", argv0, argv1);
+		return 2;
+	}
+
+	NLA_PUT_U8(msg, attr, val);
+	return 0;
+
+ nla_put_failure:
+	return -ENOBUFS;
+}
+
+static int handle_tid_config(struct nl80211_state *state,
+			     struct nl_msg *msg,
+			     int argc, char **argv,
+			     enum id_input id)
+{
+	struct nlattr *tids_array = NULL;
+	struct nlattr *tids_entry = NULL;
+	unsigned char peer[ETH_ALEN];
+	int tids_num = 0;
+	char *end;
+	int ret;
+	enum {
+		PS_ADDR,
+		PS_TIDS,
+		PS_CONF,
+	} parse_state = PS_ADDR;
+
+	while (argc) {
+		switch (parse_state) {
+		case PS_ADDR:
+			if (strcmp(argv[0], "peer") == 0) {
+				if (argc < 2) {
+					fprintf(stderr, "Not enough args for %s\n", argv[0]);
+					return HANDLER_RET_USAGE;
+				}
+
+				if (mac_addr_a2n(peer, argv[1])) {
+					fprintf(stderr, "Invalid MAC address\n");
+					return 2;
+				}
+
+				NLA_PUT(msg, NL80211_ATTR_MAC, ETH_ALEN, peer);
+
+				argc -= 2;
+				argv += 2;
+				parse_state = PS_TIDS;
+
+			} else if (strcmp(argv[0], "tids") == 0) {
+				parse_state = PS_TIDS;
+			} else {
+				fprintf(stderr, "Peer MAC address expected\n");
+				return HANDLER_RET_USAGE;
+			}
+
+			break;
+		case PS_TIDS:
+			if (strcmp(argv[0], "tids") == 0) {
+				if (argc < 2) {
+					fprintf(stderr, "not enough args for %s\n", argv[0]);
+					return HANDLER_RET_USAGE;
+				}
+
+				if (!tids_array) {
+					tids_array = nla_nest_start(msg, NL80211_ATTR_TID_CONFIG);
+					if (!tids_array)
+						return -ENOBUFS;
+				}
+
+				if (tids_entry) {
+					nla_nest_end(msg, tids_entry);
+					tids_num++;
+				}
+
+				tids_entry = nla_nest_start(msg, tids_num);
+				if (!tids_entry)
+					return -ENOBUFS;
+
+				NLA_PUT_U16(msg, NL80211_TID_CONFIG_ATTR_TIDS, strtol(argv[1], &end, 0));
+				if (*end) {
+					fprintf(stderr, "Invalid TID mask value: %s\n", argv[1]);
+					return 2;
+				}
+
+				argc -= 2;
+				argv += 2;
+				parse_state = PS_CONF;
+			} else {
+				fprintf(stderr, "TID mask expected\n");
+				return HANDLER_RET_USAGE;
+			}
+
+			break;
+		case PS_CONF:
+			if (strcmp(argv[0], "tids") == 0) {
+				parse_state = PS_TIDS;
+			} else if (strcmp(argv[0], "override") == 0) {
+				NLA_PUT_FLAG(msg, NL80211_TID_CONFIG_ATTR_OVERRIDE);
+
+				argc -= 1;
+				argv += 1;
+			} else if (strcmp(argv[0], "ampdu") == 0) {
+				if (argc < 2) {
+					fprintf(stderr, "not enough args for %s\n", argv[0]);
+					return HANDLER_RET_USAGE;
+				}
+
+				ret = toggle_tid_param(argv[0], argv[1], msg,
+						       NL80211_TID_CONFIG_ATTR_AMPDU_CTRL);
+				if (ret)
+					return ret;
+
+				argc -= 2;
+				argv += 2;
+			} else if (strcmp(argv[0], "amsdu") == 0) {
+				if (argc < 2) {
+					fprintf(stderr, "not enough args for %s\n", argv[0]);
+					return HANDLER_RET_USAGE;
+				}
+
+				ret = toggle_tid_param(argv[0], argv[1], msg,
+						       NL80211_TID_CONFIG_ATTR_AMSDU_CTRL);
+				if (ret)
+					return ret;
+
+				argc -= 2;
+				argv += 2;
+			} else if (strcmp(argv[0], "noack") == 0) {
+				if (argc < 2) {
+					fprintf(stderr, "not enough args for %s\n", argv[0]);
+					return HANDLER_RET_USAGE;
+				}
+
+				ret = toggle_tid_param(argv[0], argv[1], msg,
+						       NL80211_TID_CONFIG_ATTR_NOACK);
+				if (ret)
+					return ret;
+
+				argc -= 2;
+				argv += 2;
+			} else if (strcmp(argv[0], "rtscts") == 0) {
+				if (argc < 2) {
+					fprintf(stderr, "not enough args for %s\n", argv[0]);
+					return HANDLER_RET_USAGE;
+				}
+
+				ret = toggle_tid_param(argv[0], argv[1], msg,
+						       NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL);
+				if (ret)
+					return ret;
+
+				argc -= 2;
+				argv += 2;
+			} else if (strcmp(argv[0], "sretry") == 0) {
+				if (argc < 2) {
+					fprintf(stderr, "not enough args for %s\n", argv[0]);
+					return HANDLER_RET_USAGE;
+				}
+
+				NLA_PUT_U8(msg, NL80211_TID_CONFIG_ATTR_RETRY_SHORT, strtol(argv[1], &end, 0));
+				if (*end) {
+					fprintf(stderr, "Invalid short_retry value: %s\n", argv[1]);
+					return 2;
+				}
+
+				argc -= 2;
+				argv += 2;
+			} else if (strcmp(argv[0], "lretry") == 0) {
+				if (argc < 2) {
+					fprintf(stderr, "not enough args for %s\n", argv[0]);
+					return HANDLER_RET_USAGE;
+				}
+
+				NLA_PUT_U8(msg, NL80211_TID_CONFIG_ATTR_RETRY_LONG, strtol(argv[1], &end, 0));
+				if (*end) {
+					fprintf(stderr, "Invalid long_retry value: %s\n", argv[1]);
+					return 2;
+				}
+
+				argc -= 2;
+				argv += 2;
+			} else {
+				fprintf(stderr, "Unknown parameter: %s\n", argv[0]);
+				return HANDLER_RET_USAGE;
+			}
+
+			break;
+		default:
+			fprintf(stderr, "Failed to parse: internal failure\n");
+			return HANDLER_RET_USAGE;
+		}
+	}
+
+	if (tids_entry)
+		nla_nest_end(msg, tids_entry);
+
+	if (tids_array)
+		nla_nest_end(msg, tids_array);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+
+COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] [sretry <num>] [lretry <num>] "
+	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts [on|off]]",
+	NL80211_CMD_SET_TID_CONFIG, 0, CIB_NETDEV, handle_tid_config,
+	"Setup per-node TID specific configuration for TIDs selected by bitmask.\n"
+	"If MAC address is not specified, then supplied TID configuration\n"
+	"applied to all the peers.\n"
+	"Examples:\n"
+	"  $ iw dev wlan0 tids 0x1 ampdu off\n"
+	"  $ iw dev wlan0 tids 0x5 ampdu off amsdu off rtscts on\n"
+	"  $ iw dev wlan0 tids 0x3 override ampdu on noack on rtscts on\n"
+	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x1 ampdu off tids 0x3 amsdu off rtscts on\n"
+	);
-- 
2.11.0

