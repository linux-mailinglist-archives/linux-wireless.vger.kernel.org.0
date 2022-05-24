Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1AE53293D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiEXLi7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiEXLi6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:58 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910F88D68D
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIaHgoLU0N78Wwomd0BbfZvVVDLVsW60Dp3T8c6r1VyGtke6V6944Cgng4545EHx23sDksjZTboWtsn8SsnOXLKXfgJ84wrXgn64jNaXXBITiH9V2xHO9Bry0b0jQgVsM1uL8G8Tjnb/PwH+i6y0Fgts6gji4aKKWUfNT0xMrYKOkIDdHQ/q2GDCcQCTWatNroeKGh/m/bVrNQTOE+9+WhNCSk71SMlHDTUXrG9xGbl9X4bE+cGFiEaaSfTHTeYaKdqXbFRdyqsq0YiY0t9ylBsfFHj9HY/Kmm2uYpfLAGgZMlb729x+gqZ+94w3ZTdgIoWDl4DgArbzlkcXGIXQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogZKDoI7cvYL82g31NEXuCUB8DODR2apYpQpHvJ9eog=;
 b=WyHZK6nySf7i9mijf97g3g8iUePrn1OFTBwjo5qhRkBp2SFoqd6jD4ZNlutbV8EGfstsYeesiKQUKXvNnuCfDrGWOUmEVeO80FXgHOk0o+6PiGeoZAw5HyK5DQnnd0nZMLMgx9HKTtg5QsCmPAekKwsOfAphwTL9UrJZBuWt4YZE+jdbEI7Qrahq+bB5RsYHKWJfIrKjWh6NNGglK1HAHQ78xqW8y5U+x063CkTrJwmIkY4x84jjhJyxb/k1aV13tGJBD701G1pob9YTF2h9oc/Lj68XAPGfqPIykJpe1MEP4u/Dtkb8a8jZRfUrr0LsmbpAvGjbNu6qx7F0a99qcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogZKDoI7cvYL82g31NEXuCUB8DODR2apYpQpHvJ9eog=;
 b=MCo3n909G48GFxjsnpp3NRiPfYky7asLTFouw4gq6YarPi4V+6skXqJBmJf6ik8mRKrKDoiCoSzjF5OEBimg9mxRN3mBWQMXN+fiu6M8BponcQYKyraSxRGRD0jYS3qEjeHlKC1V05ZWIKV5fYIHGVi+/XefsMMKRgO/nnbnhj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:38:40 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:40 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 36/96] cl8k: add key.c
Date:   Tue, 24 May 2022 14:34:02 +0300
Message-Id: <20220524113502.1094459-37-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05668b09-9693-4631-d4ea-08da3d79e131
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB03059A29261F81C7B09D6C1DF6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeVbnOEMDbhf/UX8ZDYaJ36iAMf2prNfPodZbjnKQzG1N7WPp2rinW0XkctMtHtTzpRXsuqDCtmzyo05xw4tsvdPnABDJ8mZEFrze5QV0edBy+M/sKXklz5A/ZofLOhHJJ2SulDkwa9xkV7gHQW8QM4MKbrAwjk8dn3hFSCowAxUH+npBz4nvwvYW0IZk+LlElb6ZT4P2rmXrSS2aiVRFibSE30I8wdENh1tdVsmqmnS2ycIx8pAt6T44TOqWAgubrlaEA1GPLWNYuJYfkk7jUbJt26IstyOMlRzJcybRjPgtJCikz2BZUH0hDYLOswnoPOhvNb9Oq3cjMhp75naQoFMptj6JMigRfE5GdEw0AaUtwq4iZ+TcY6kLtBeFDS18N04cwr5S0Hg3+dZA+sLx9rZJ3osYIaIlq4LWz2KcK5xlWetc9QfyUReD9Irx4l3QZSHkiO/Hkl23+GrdS5iKZK21eoduSRrZ7h8l/BdL3oFHAqjiHHvhNXKAL04Wfp8w/thFmPhYq+n1dzRLyGp9+N/KIa7fsU6mjbN2SaMMz8wUipaC/RQpCQh5LfzNIl3DnDxCslWhIrCcFUKX6flQOEdMKZxQk4Niqkgx3VI3VZlqx3EhVZEOLIaDkIejT/bFf9XX75v4rPnt1ObwPhgDo5G7afe7CkrsZlKIppAr3nRyZ/WnrrcDoR+y4Z0E3yXGsljHnobQgjNKA4BLCG57i48GclhSZnULgajAkatPBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(83380400001)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3gcNOhqgJ+5vp67nheIhDZVx9ZE1oVl6jvdHwmnEY8OzjFop4Li+V6fS/rIA?=
 =?us-ascii?Q?4gE7pLJOc/5cUw8qmBMeynB5CwQYJrC86foIsPxj5tMSRT3vQ+TwrGTEUvaj?=
 =?us-ascii?Q?lr1sDNzVTwEq8mhcID08gtaG0CELMvkVFcOhm5dKqoVZPUsx+OQwEJZvYOr3?=
 =?us-ascii?Q?nsTmxNDi9+HLOtUCebFMJpYn3SBnVG8Z8eMOYZB9oIUMhgLmubG1B746wbOy?=
 =?us-ascii?Q?u1zA18YAB9Cqet53s8IuJFdT4hZXuaPVmF4K/FjqWYPmxZXh/DnQ1oeZYkq3?=
 =?us-ascii?Q?jHi7i5UJA5CJbijWxbHoRQqRPFnlxQT0z381bW0wyxhP4ngMfe5i2xp6+jNA?=
 =?us-ascii?Q?OK5MlbpjFq9wJQDJ527yyZZx0/iHhlvm9oML/n+HHoNSfGfMvZk4/V2oOxne?=
 =?us-ascii?Q?Ae3Z3N3n2lePq1wHgVX5+ZW+iCXCE92OXDuOEK3P+bk9wurdN4lWN874VpOb?=
 =?us-ascii?Q?vRprIwoB/OrnjR/Onv1itVCzxMsLBWymtlbM9B67RtGU5xMWleknbbnjZK9D?=
 =?us-ascii?Q?kpI/9ozi5ps4vVvPvTUBhW5kUX8DIhgRCEOqhYEqnoBm9s0t/YynRdZ3rbmc?=
 =?us-ascii?Q?FNyLZcx5cdanSOIcOfLljLN62LMBcbChrTQjwehsw7fOTsARfTW3hPbcjiNn?=
 =?us-ascii?Q?G5UudmvzKW6iAf0Xf/czRfn8mOde1nXX0k7ggjpqltuDBVSg0nH205RfrfD5?=
 =?us-ascii?Q?spsODdanpzY0u4cQgDTV1xT4IfF9F/Vzh3FQFTOYdyMQEA11iHBn3R2WKYwS?=
 =?us-ascii?Q?mVdKj8S5RrH06omVixYSY3VG0iPBAO6q3GUERXMaUMkpDigHMtaPOCmAy1io?=
 =?us-ascii?Q?RlaCbXYUU0MuirRKHSZJ5LRVZ6HD3v8xeTutg2LXIuYVBMhwlfxNAVrPg5af?=
 =?us-ascii?Q?z+GxFi8GsyZ1kYgKWRnynoqG0wLgcH1Flgs8D2kJ0VRNHqqS489Rx3hIVzFk?=
 =?us-ascii?Q?BU5znonXO31rvWw0r/kn1xXb5n84Zkd6cC72f1XMwQ41woHvLCwcalR9Wqk4?=
 =?us-ascii?Q?FQOYA77cXWGfaUc7nJvqWqj7p8Tzxj3bfbCUKxuZklXSryZWBFaZr68EUIOZ?=
 =?us-ascii?Q?k7jAc1NIvhs/9b+vTlvKVfyLm/L7mYZnnuI/TREPwJd62enpglyvRN3Z7p+K?=
 =?us-ascii?Q?cUT+hPPUxa/fuPJdcx7SLIUNK5LgO3Nu/l4zN4BWHM/UK79GLWUi2JsJHk+2?=
 =?us-ascii?Q?hH44w71S8op5Y84ukRjinz0goldwnJsw1xvRieRGE6pBqm3bPieajNKEvQ46?=
 =?us-ascii?Q?XWbBtAEpY0a0cV+q/bT7A1+DRVA5kP9FsF55ZuUPCkfoEjqBd+Vp/2r0iU4C?=
 =?us-ascii?Q?fCdolrcMhKmiXsleKuGmi5VrhJV2sbfsFYq+yuaM31okHYNFHqbDFZqdk9ZJ?=
 =?us-ascii?Q?83AV7gRNgi+47WCigCxzxfEo8Lt+IYwrWKTkuZFEpv4ke85eXsd20PkXUDOO?=
 =?us-ascii?Q?YBj3wDFPGG8XUgN9HaeWIcIDRh7ENw2scbMbE1XVDlOQk7+Jx0FWhwYB4wXe?=
 =?us-ascii?Q?vtYEalO/foz7zWuijq3MEWPuA+kkgyJtK6VbzVPSfQWvLy+8B8fwDYKJc3Bt?=
 =?us-ascii?Q?dkB5HuOR7EUT4njH92sP7d1w1x/Hyz2i0xvXds7Bv7F+c4YRsGFS7GbCmYcf?=
 =?us-ascii?Q?kPboPJOLyuFmn7SH63TH8nTh81n0TNYoiAq16eV8PqgnHeHSNyp6ABURIuXo?=
 =?us-ascii?Q?WXJ4Y1NuhgrUSZiuE92YsqSeyWlwlGyD9Q5xdbJ5H8mNnL0rubxxGHXgtqy9?=
 =?us-ascii?Q?CVZ6Azy+WrRHYH0QmmOxL43d9wH75Lk=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05668b09-9693-4631-d4ea-08da3d79e131
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:10.6398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lE+wifefK5a7nJLhL0jDEF6DtcqeBsPAyeSaKNl0CljvFQzNpDXQ5ywe8kJPYiAQz0b5b6oHW4DjkGiHEW7bdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/key.c | 382 +++++++++++++++++++++++++
 1 file changed, 382 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/key.c

diff --git a/drivers/net/wireless/celeno/cl8k/key.c b/drivers/net/wireless/celeno/cl8k/key.c
new file mode 100644
index 000000000000..99821b86a795
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/key.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "phy.h"
+#include "fw.h"
+#include "sta.h"
+#include "enhanced_tim.h"
+#include "key.h"
+
+#define DECRYPT_CCMPSUCCESS_FLAGS (RX_FLAG_DECRYPTED | RX_FLAG_MIC_STRIPPED)
+
+void cl_vif_key_init(struct cl_vif *cl_vif)
+{
+	INIT_LIST_HEAD(&cl_vif->key_list_head);
+}
+
+static struct cl_key_conf *cl_vif_key_find(struct cl_vif *cl_vif,
+					   struct ieee80211_key_conf *key_conf_in)
+{
+	struct cl_key_conf *key, *tmp, *out = NULL;
+
+	if (!key_conf_in)
+		return NULL;
+
+	list_for_each_entry_safe(key, tmp, &cl_vif->key_list_head, list) {
+		struct ieee80211_key_conf *key_conf = key->key_conf;
+
+		if (key_conf_in->keyidx != key_conf->keyidx)
+			continue;
+
+		out = key;
+		break;
+	}
+
+	return out;
+}
+
+static struct ieee80211_key_conf *cl_vif_key_conf_default(struct cl_vif *cl_vif)
+{
+	struct cl_key_conf *key, *tmp;
+	struct ieee80211_key_conf *out = NULL;
+
+	list_for_each_entry_safe(key, tmp, &cl_vif->key_list_head, list) {
+		if (key->key_conf->keyidx != cl_vif->key_idx_default)
+			continue;
+
+		out = key->key_conf;
+		break;
+	}
+
+	return out;
+}
+
+static int cl_vif_key_add(struct cl_vif *cl_vif, struct ieee80211_key_conf *key_conf)
+{
+	struct cl_key_conf *key = NULL, *old_key = NULL;
+
+	key = kzalloc(sizeof(*key), GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	if (!list_empty(&cl_vif->key_list_head))
+		old_key = list_first_entry(&cl_vif->key_list_head, struct cl_key_conf, list);
+
+	cl_vif->key_idx_default = old_key ? old_key->key_conf->keyidx : key_conf->keyidx;
+	key->key_conf = key_conf;
+	list_add_tail(&key->list, &cl_vif->key_list_head);
+
+	return 0;
+}
+
+static void cl_vif_key_del(struct cl_vif *cl_vif, struct ieee80211_key_conf *key_conf_in)
+{
+	struct cl_key_conf *key, *tmp;
+
+	if (!key_conf_in)
+		return;
+
+	list_for_each_entry_safe(key, tmp, &cl_vif->key_list_head, list) {
+		struct ieee80211_key_conf *key_conf = key->key_conf;
+
+		if (key_conf_in->keyidx != key_conf->keyidx)
+			continue;
+
+		list_del(&key->list);
+		kfree(key);
+	}
+
+	if (!list_empty(&cl_vif->key_list_head)) {
+		struct cl_key_conf *new_key = list_first_entry(&cl_vif->key_list_head,
+							       struct cl_key_conf, list);
+
+		cl_vif->key_idx_default = new_key->key_conf->keyidx;
+	}
+}
+
+static int cl_vif_key_check_and_add(struct cl_vif *cl_vif,
+				    struct ieee80211_key_conf *key_conf)
+{
+	struct cl_key_conf *key = cl_vif_key_find(cl_vif, key_conf);
+
+	if (key) {
+		cl_dbg_warn(cl_vif->cl_hw,
+			    "[%s] error: previous key found. delete old key and add new key\n",
+			    __func__);
+		cl_vif_key_del(cl_vif, key->key_conf);
+	}
+
+	return cl_vif_key_add(cl_vif, key_conf);
+}
+
+static inline void cl_ccmp_hdr2pn(u8 *pn, u8 *hdr)
+{
+	pn[0] = hdr[7];
+	pn[1] = hdr[6];
+	pn[2] = hdr[5];
+	pn[3] = hdr[4];
+	pn[4] = hdr[1];
+	pn[5] = hdr[0];
+}
+
+static int cl_key_validate_pn(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	int hdrlen = 0, res = 0;
+	u8 pn[IEEE80211_CCMP_PN_LEN];
+	u8 tid = 0;
+
+	hdrlen = ieee80211_hdrlen(hdr->frame_control);
+	tid = ieee80211_get_tid(hdr);
+
+	cl_ccmp_hdr2pn(pn, skb->data + hdrlen);
+	res = memcmp(pn, cl_sta->rx_pn[tid], IEEE80211_CCMP_PN_LEN);
+	if (res < 0) {
+		cl_hw->rx_info.pkt_drop_invalid_pn++;
+		return -1;
+	}
+
+	memcpy(cl_sta->rx_pn[tid], pn, IEEE80211_CCMP_PN_LEN);
+
+	return 0;
+}
+
+void cl_vif_key_deinit(struct cl_vif *cl_vif)
+{
+	struct cl_key_conf *key, *tmp;
+
+	list_for_each_entry_safe(key, tmp, &cl_vif->key_list_head, list) {
+		list_del(&key->list);
+		kfree(key);
+	}
+}
+
+static int cl_cmd_set_key(struct cl_hw *cl_hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
+{
+	int error = 0;
+	struct mm_key_add_cfm *key_add_cfm;
+	u8 cipher_suite = 0;
+
+	/* Retrieve the cipher suite selector */
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		cipher_suite = MAC_CIPHER_SUITE_WEP40;
+		break;
+	case WLAN_CIPHER_SUITE_WEP104:
+		cipher_suite = MAC_CIPHER_SUITE_WEP104;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		cipher_suite = MAC_CIPHER_SUITE_TKIP;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+		cipher_suite = MAC_CIPHER_SUITE_CCMP;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		cipher_suite = MAC_CIPHER_SUITE_GCMP;
+		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+
+	error = cl_msg_tx_key_add(cl_hw, vif, sta, key, cipher_suite);
+	if (error)
+		return error;
+
+	key_add_cfm = (struct mm_key_add_cfm *)(cl_hw->msg_cfm_params[MM_KEY_ADD_CFM]);
+	if (!key_add_cfm)
+		return -ENOMSG;
+
+	if (key_add_cfm->status != 0) {
+		cl_dbg_verbose(cl_hw, "Status Error (%u)\n", key_add_cfm->status);
+		cl_msg_tx_free_cfm_params(cl_hw, MM_KEY_ADD_CFM);
+		return -EIO;
+	}
+
+	/* Save the index retrieved from firmware */
+	key->hw_key_idx = key_add_cfm->hw_key_idx;
+
+	cl_msg_tx_free_cfm_params(cl_hw, MM_KEY_ADD_CFM);
+
+	/*
+	 * Now inform mac80211 about our choices regarding header fields generation:
+	 * we let mac80211 take care of all generations
+	 */
+	key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
+	if (key->cipher == WLAN_CIPHER_SUITE_TKIP)
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
+
+	if (sta) {
+		struct cl_sta *cl_sta = (struct cl_sta *)sta->drv_priv;
+
+		cl_sta->key_conf = key;
+	} else {
+		error = cl_vif_key_check_and_add((struct cl_vif *)vif->drv_priv, key);
+	}
+
+	return error;
+}
+
+static int cl_cmd_disable_key(struct cl_hw *cl_hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_key_conf *key)
+{
+	int ret = 0;
+	struct cl_sta *cl_sta = NULL;
+	struct cl_tx_queue *tx_queue = &cl_hw->tx_queues->single[HIGH_PRIORITY_QUEUE];
+
+	if (sta) {
+		cl_sta = (struct cl_sta *)sta->drv_priv;
+
+		cl_sta->key_conf = NULL;
+		cl_sta->key_disable = true;
+
+		/*
+		 * Make sure there aren't any packets in firmware before deleting the key,
+		 * otherwise they will be transmitted without encryption.
+		 */
+		cl_sta->stop_tx = true;
+		cl_single_cfm_clear_tim_bit_sta(cl_hw, cl_sta->sta_idx);
+		cl_agg_cfm_clear_tim_bit_sta(cl_hw, cl_sta);
+		cl_txq_flush_sta(cl_hw, cl_sta);
+		cl_single_cfm_poll_empty_sta(cl_hw, cl_sta->sta_idx);
+		cl_agg_cfm_poll_empty_sta(cl_hw, cl_sta);
+
+		if (!list_empty(&tx_queue->hdrs)) {
+			spin_lock_bh(&cl_hw->tx_lock_single);
+			cl_enhanced_tim_set_tx_single(cl_hw, HIGH_PRIORITY_QUEUE,
+						      tx_queue->hw_index,
+						      false, tx_queue->cl_sta,
+						      tx_queue->tid);
+			spin_unlock_bh(&cl_hw->tx_lock_single);
+		}
+	} else {
+		cl_vif_key_del((struct cl_vif *)vif->drv_priv, key);
+	}
+
+	ret = cl_msg_tx_key_del(cl_hw, key->hw_key_idx);
+
+	if (cl_sta)
+		cl_sta->stop_tx = false;
+
+	return ret;
+}
+
+int cl_key_set(struct cl_hw *cl_hw,
+	       enum set_key_cmd cmd,
+	       struct ieee80211_vif *vif,
+	       struct ieee80211_sta *sta,
+	       struct ieee80211_key_conf *key)
+{
+	int error = 0;
+
+	switch (cmd) {
+	case SET_KEY:
+		error = cl_cmd_set_key(cl_hw, vif, sta, key);
+		break;
+
+	case DISABLE_KEY:
+		error = cl_cmd_disable_key(cl_hw, vif, sta, key);
+		break;
+
+	default:
+		error = -EINVAL;
+		break;
+	}
+
+	return error;
+}
+
+struct ieee80211_key_conf *cl_key_get(struct cl_sta *cl_sta)
+{
+	if (cl_sta->key_conf)
+		return cl_sta->key_conf;
+
+	if (cl_sta->cl_vif)
+		return cl_vif_key_conf_default(cl_sta->cl_vif);
+
+	return NULL;
+}
+
+bool cl_key_is_cipher_ccmp_gcmp(struct ieee80211_key_conf *keyconf)
+{
+	u32 cipher;
+
+	if (!keyconf)
+		return false;
+
+	cipher = keyconf->cipher;
+
+	return ((cipher == WLAN_CIPHER_SUITE_CCMP) ||
+		(cipher == WLAN_CIPHER_SUITE_GCMP) ||
+		(cipher == WLAN_CIPHER_SUITE_GCMP_256));
+}
+
+void cl_key_ccmp_gcmp_pn_to_hdr(u8 *hdr, u64 pn, int key_id)
+{
+	hdr[0] = pn;
+	hdr[1] = pn >> 8;
+	hdr[2] = 0;
+	hdr[3] = 0x20 | (key_id << 6);
+	hdr[4] = pn >> 16;
+	hdr[5] = pn >> 24;
+	hdr[6] = pn >> 32;
+	hdr[7] = pn >> 40;
+}
+
+u8 cl_key_get_cipher_len(struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *key_conf = tx_info->control.hw_key;
+
+	if (key_conf) {
+		switch (key_conf->cipher) {
+		case WLAN_CIPHER_SUITE_WEP40:
+		case WLAN_CIPHER_SUITE_WEP104:
+			return IEEE80211_WEP_IV_LEN;
+		case WLAN_CIPHER_SUITE_TKIP:
+			return  IEEE80211_TKIP_IV_LEN;
+		case WLAN_CIPHER_SUITE_CCMP:
+			return  IEEE80211_CCMP_HDR_LEN;
+		case WLAN_CIPHER_SUITE_CCMP_256:
+			return  IEEE80211_CCMP_256_HDR_LEN;
+		case WLAN_CIPHER_SUITE_GCMP:
+		case WLAN_CIPHER_SUITE_GCMP_256:
+			return  IEEE80211_GCMP_HDR_LEN;
+		}
+	}
+
+	return 0;
+}
+
+int cl_key_handle_pn_validation(struct cl_hw *cl_hw, struct sk_buff *skb,
+				struct cl_sta *cl_sta)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+
+	if (!ieee80211_is_data(hdr->frame_control) ||
+	    ieee80211_is_frag(hdr))
+		return CL_PN_VALID_STATE_NOT_NEEDED;
+
+	if (!(status->flag & DECRYPT_CCMPSUCCESS_FLAGS))
+		return CL_PN_VALID_STATE_NOT_NEEDED;
+
+	if (!cl_sta)
+		return CL_PN_VALID_STATE_NOT_NEEDED;
+
+	if (cl_key_validate_pn(cl_hw, cl_sta, skb))
+		return CL_PN_VALID_STATE_FAILED;
+
+	status = IEEE80211_SKB_RXCB(skb);
+	status->flag |= RX_FLAG_PN_VALIDATED;
+
+	return CL_PN_VALID_STATE_SUCCESS;
+}
-- 
2.36.1

