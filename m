Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8B91B077C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgDTLfs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 07:35:48 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:27138 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbgDTLfs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 07:35:48 -0400
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03KBZhRj026294;
        Mon, 20 Apr 2020 05:35:44 -0600
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by m0059812.ppops.net with ESMTP id 30fv3svmj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 05:35:44 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcBVaO4wFDjnASrOTNg9GcVzw/nnsaXnQR04O1xJoYJfJGyUtc7qkm/NncAXy7CYfl4f1rJGDZE8SxvzHGVLw55Po6XqbIsuO1Nk4nZDxpfBhhHtFNZve7qSqr1PY4+p6gMnJnas+K7rux+Y8w7Phj9xb7jm+qf34Xo0lHQk0M3fP5k7IHzK/ZiditIam+0dRjpC1FZi/pgG7gnRhjnV0rj6cDTzo+Vs5BYfH/z6Ei/JpFe5MiDK3BGbPU0NF9iZrkTQ+wcoHMT+rSRefUc/5SwWW7SB2Qz+oV9Wu/2IqvYMeT4YR3RjCwfyTOg7FBB9cfRWt+HKqMS6yOZBdj5+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAIjepzaDnZinsJSW8HKsJ+UcjpIH71OMgkZiuoceJE=;
 b=Kn4xAtzX973v/Tycf59QJOg4BpzMNN90QUmDIWGz8HwnYW78OhbQ4JqJzA2l9lGzkwnZioWc4ev2HHP1Ywvq+vye9dhOMAmtkWGYkuvSb7uBFDyzwMXPMBOKQNYwnBYuIrklVRxszRAUGZv2M5PeIVmO6I78dKrw4LScdnZevnbvxqYm1mcZqz78LdW2UUobFhaW9sbmAoihR2dtWtlQprUDjmiO2APQMyLFNNtNVuVachMb4Pmzw2E7rUIGDZkZjOUJ4PGIwgnoZF5FrQHHBmgB6EtQrKfjnPOCi7OY3rIzelhVDTRMrQW7gOl7WuYXPZKU7VczXsLuNDKUNBmJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAIjepzaDnZinsJSW8HKsJ+UcjpIH71OMgkZiuoceJE=;
 b=MX+Jelx8km0WBbkvr8g6y599YbwpsJsv8UCAxArWGDSPoJ1jUYGQXLI+WYNugS7TT+/LHli/BPB1RkcOzOD+mS1J90PyPHdVeAk4gPYfr8rWhEkoATe0GEGWRFyxSNoeUGS67Vc7VY0qaQe6+ej7sV3lJzmFMyq04VNMHGbEBw0=
Received: from BYAPR05MB6309.namprd05.prod.outlook.com (2603:10b6:a03:cf::22)
 by BYAPR05MB5413.namprd05.prod.outlook.com (2603:10b6:a03:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.20; Mon, 20 Apr
 2020 11:35:39 +0000
Received: from BYAPR05MB6309.namprd05.prod.outlook.com
 ([fe80::d8c0:3fd8:fcf2:2221]) by BYAPR05MB6309.namprd05.prod.outlook.com
 ([fe80::d8c0:3fd8:fcf2:2221%3]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 11:35:39 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3605.namprd05.prod.outlook.com (2603:10b6:910:51::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Mon, 20 Apr
 2020 11:34:54 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 11:34:54 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH 4/4] nl80211: simplify peer specific TID configuration
Date:   Mon, 20 Apr 2020 14:34:37 +0300
Message-ID: <20200420113437.16998-5-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
References: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0101CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::22) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0101CA0012.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 11:34:52 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9df923b4-26e5-42c8-afb9-08d7e51ed850
X-MS-TrafficTypeDiagnostic: CY4PR05MB3605:|BYAPR05MB5413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB3605E9DD0FB5FD0F356ECAD0A3D40@CY4PR05MB3605.namprd05.prod.outlook.com>
X-Moderation-Data: 4/20/2020 11:35:33 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6309.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(39840400004)(346002)(136003)(366004)(396003)(376002)(1076003)(2906002)(66476007)(66556008)(478600001)(186003)(16526019)(7696005)(52116002)(6486002)(8936002)(2616005)(956004)(81156014)(316002)(66946007)(26005)(86362001)(54906003)(4326008)(36756003)(8676002)(6916009)(5660300002)(107886003)(6666004)(103116003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaMyeLLmD9r/L+RfHOLKT+ArtCcvfEJ/O1IijZMgJqvYCnTcTm5sNMLbKDv5pxVJtYvNyggzbnFDK4dEZzvQEKLFogwCkS4rXdVeW71JG9NMSK7CEyEOLk/K7XrCWDte4OmWwnn3QRZDqq+M2/LMxGC6ZoM8fta4/TiOGivodr9SJCvCf3nz5L/604Lb1fXs7jj1JUSeni7etMah2wFcroHtnGhuQA+cQ5s3krwhCr81RD9oubqBrgH103/EmmVSOrmTmjFyshh2U8U8tx7aW21dVsLmCvlQEhEjkfzkycVE3RScSvqQJ/lUyNrRf+npoJbxZsdWBCYMI1G26et+hgz+GvFL+lrWwqaIl3VBNEQ7LZptJavZ9vrdkzD3FWiUdxysyiLQmcPmdyvaw2saHAipKcZOlMdd8tARfx+Dc7g7BMelpduNTy4jd+z8Rrog
X-MS-Exchange-AntiSpam-MessageData: Gr+CzTKBrkTsR6Enn/u8fLGo14X1EcSBtQbtjeff5I0RSYA057P6vbSRpqP7ji9K0OzZ2cFQdvjKIwg/3pF82SCafFmQuKF0SBFyMe8nVoJZD11uaQgsq4jyHjVu97WjebXdu+B7CvhWYsXb2BPIGUlMQxAeRYk+zWHu7MdZCdvAyQGD+ZsdQ9Mhz1DJzZHosd4a5hWm4kRL6eyq9we96/6iFRfnNY5YycC+3/uqSSIbwP+1lHAIE3GkCwdPnVmTIqEL3XHCrgP97mClLRFydq/CCp9IbDO1S8KRvmNtfnNlWLyEFj/r556re744h6zm5c/ABEyJQ+3r7dUAmr9oTagOggbk0ILwqaro0GlzgUd1dBYD9mEu5SAv/RDwxjbreEJ8nxgQucecksKTowDbOz4PGPTwzPNUPQO5C6d7spcHJhbxl2Rq+tT2GYSjYxta3fSFnyPXglGYcvh41qbx5/eF5UuHrv2hxxwwTarWrxZRyM++GTKiKHbQwWr03H+5s7nbgH83rHjcSvYSibdOw+fB9B3g17GtvOJwk3iLFRCD51gT9mpclQfAQJhbjVc5N0vFEb0EBp46EID8PUQEXVdGQqrch7mJarwDmE6mOkTkkEnmxr4U497a9ALYe9Ar7M7gWPKMXZT5MBu31SP/wHe7Zm7HjNji7Ftmn+9maiHb5CHpxxwP8nXgNfsPKh+CoL5tWVcBWDQyTYEFpbmbtEgvYxPQer70zkAEWdDhWoybtXXo7bzchS0hKvWo1K2ltz0zRBo8MWHwHy/7qQTYbYMYoK9HuphWevVS/xruM3c=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df923b4-26e5-42c8-afb9-08d7e51ed850
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8i0ujGzRDhmn1gbC+LLB/Jd0mli0hhgaa4D8mS7VaUgFAjSAFU7w6iVaytOPmcB4b1rib8aNhjgqE2H6plXhC+p0RIAFlEb+jgfliQFQiD2XdMOmYOiqE96RQwx83aLQjDjR0SqL88tFSEJvdu15jo9rbeDz6XmvvQ81XuKYBVIvHyo1hN5kk67l3pcx++xD6KY9VziexTkHukEecEQlvg3IaRUUHesthsAKU+ZkpBY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 11:35:39.2256
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5413
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Current rule for applying TID configuration for specific peer looks overly
complicated. No need to reject new TID configuration when override flag is
specified. Another call with the same TID configuration, but without
override flag, allows to apply new configuration anyway.

Use the same approach as for the 'all peers' case: if override flag is
specified, then reset existing TID configuration and immediately
apply a new one.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 include/uapi/linux/nl80211.h | 10 ++++------
 net/wireless/nl80211.c       |  5 +----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1bf34a39c776..003e25ce3899 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4807,12 +4807,10 @@ enum nl80211_tid_config {
  *	(%NL80211_TID_CONFIG_ATTR_TIDS, %NL80211_TID_CONFIG_ATTR_OVERRIDE).
  * @NL80211_TID_CONFIG_ATTR_PEER_SUPP: same as the previous per-vif one, but
  *	per peer instead.
- * @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribue, if no peer
- *	is selected, if set indicates that the new configuration overrides
- *	all previous peer configurations, otherwise previous peer specific
- *	configurations should be left untouched. If peer is selected then
- *	it will reset particular TID configuration of that peer and it will
- *	not accept other TID config attributes along with peer.
+ * @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribue, if set indicates
+ *	that the new configuration overrides all previous peer
+ *	configurations, otherwise previous peer specific configurations
+ *	should be left untouched.
  * @NL80211_TID_CONFIG_ATTR_TIDS: a bitmask value of TIDs (bit 0 to 7)
  *	Its type is u16.
  * @NL80211_TID_CONFIG_ATTR_NOACK: Configure ack policy for the TID.
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ea0e588b6f6a..03f7870875a0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14058,10 +14058,7 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 		if (rdev->ops->reset_tid_config) {
 			err = rdev_reset_tid_config(rdev, dev, peer,
 						    tid_conf->tids);
-			/* If peer is there no other configuration will be
-			 * allowed
-			 */
-			if (err || peer)
+			if (err)
 				return err;
 		} else {
 			return -EINVAL;
-- 
2.11.0

