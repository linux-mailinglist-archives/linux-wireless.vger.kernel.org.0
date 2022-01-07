Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82114873A4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 08:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiAGHgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jan 2022 02:36:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53100 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235128AbiAGHgg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jan 2022 02:36:36 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2074QvYP009297;
        Fri, 7 Jan 2022 07:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ePxy+W7f1GNZkrHTHu4rQptoOzum4leHVESQFyP6KNk=;
 b=nvrTa4ZRKuLYHFueJl3br6YVgqvTi9a+FPhQ1uQnZUfY31iZuECm1uSu/Ogy4Q1uenuH
 wuA/FNJBJx2iXS2qFKvWXgoV04mWlFkdJU7gWgquPrkpcnxWXczp341ujWo4bvtwyRoB
 /SW/Xvl7VrusJwkEFoev1koY1kKmfSCAceIxT+GL4yvd03OUhMotRzxMvbcibI+sRMyZ
 t5MglYv3/bBvE2zEiYQpzJHKCPfTXkRL9v/SCZj7A8ZALLFucH3sokk0+303vFN2Ri+c
 BBMpnO9uPsKjaVOIRU/tuKxjWn2kdf9Qiiga+OClF2tWnCxajZos5PkhN2sCCCZLX11t wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vh98av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:36:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2077VnQZ182082;
        Fri, 7 Jan 2022 07:36:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3020.oracle.com with ESMTP id 3de4vvy29b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF+xJkssoj7tSCvNBC9F2C3qKTB682A0HY2FtacipWQn2FZd2nxeqzrUsx1TzLO+j+N0KrRlQnmyAfEIb9hwf8Gn1KCZNzlO3cKYZ4jlh13s7ws3tjtVigA11LJdciRWm6lesvlETsy+mLmM3JTp/i/sZ0zbX6+t9KkhqCPPmAs2zsQJk//bZTdNwCZRexd0GNZzcde6BuQKJp8fCIpbmUyHwY4D4U0p7oyebyuvbQQCj7qTiV/t2MxTlLLEe34mD0OruFA1nLAYqbMiHdcv11MQHFrg9trSguqAGTbYSP0SDYjPHGP7+3egQHoh3ySE9nu7AB5BPMk2cNHdfa357A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePxy+W7f1GNZkrHTHu4rQptoOzum4leHVESQFyP6KNk=;
 b=mmon6c/BDh6OFJblUa94x0K8gJ81Gjo3QSFGoiQBwoo3IE2dXX4CmXrMBS5RmTLkWQKLUZmKWbevCCMAGcKCwCDEQpOJQZI7m07lFsdmcOjc9RE6B1MPm+P2ym0LPHx08QPK1gD1FAp3VmfGwGft5xGYumogCxXdPQdZ5tiT9aGOLTJmXKb31GJZ9lor0winQhOCyNUg0uMM57ZXEacgDPCmf+HkvQqkgxVPyrKA4knWF0SeYlUj1poOfGTZfbpz8NclVUDpB/aUat2BtwPz+uTXrm6oX8c5a3kkndukH+lG5kyfTvzDCM0M8SpWsqn9clygBK7tlfpUwHxdqX1JBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePxy+W7f1GNZkrHTHu4rQptoOzum4leHVESQFyP6KNk=;
 b=O27ybwXcXE+JnDzpa/JSNLYs5B7nZxJ5/M+5Mo+P4VjumH/OQQYopcMZZ1NwiqxqSs0mae996PRePJvGEGj8eTqHLnQHI7QhzBGz62lHXZALMAfID1hBIlRL7KXpR7k/2I7Axp1CqZgT+xUecPPYB8N/HfCMYWJqTohUGNR4+VE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5752.namprd10.prod.outlook.com
 (2603:10b6:303:18d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 07:36:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:36:22 +0000
Date:   Fri, 7 Jan 2022 10:36:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix a couple information leaks
Message-ID: <20220107073609.GH22086@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d416287-513b-434c-2c16-08d9d1b06704
X-MS-TrafficTypeDiagnostic: MW4PR10MB5752:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB575296D151B908996B78656A8E4D9@MW4PR10MB5752.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcZbwEKY/UHzmt/jZvps5YSqrfA7je26XcWcgyunqTesWQnaYIjxcC4erIXu8wMUfnUm+JM5fOhm9jgA3/L6HPl7kaK1fcsaY45RlyeAT0XMotMfYCdAA2k3w0q9lJef2GOQPVcKlAkFGX1j9z8ufYJRiuIF/j6DIBW2LvMNRTrXmQyR6K6EgHwxUr95wwtfVCoJYvyi8gOwqcn852Wz02ES4LCO5zx6GEoc7rPFyJJU9PRg56+bR8dhBflyvKRDe5RuCnZ+DGhXpwYgqXbkwM1c6V61rEpuMZqTxqgrV1VIJBRSJmj4aqpsFi4GSSxmSFpRbkbtZPToeX6/cjIYxZzPddCp95yWVP410Y1RBaVzk9jn/tiL4zlM5QTQQKbkOvDoQgtBNYz0OUHw2qAzK4aW2UWhtYkq6O6TS08zFIKfALNYRiOaDMTiSa3d5e3HK2MHQn/zfGPp8echt+WDgOr28FubNucl5E5Tj8+R/h1uWI3WCvbhle8k4LW7cFTvD/Jt7slpFt7JXiUBeGFmYvjPwuCASK+DMRAO9aUeqXbSX3gpRk3Y3WrQymfSxyaWTZ8DTvIYU9RRdOTHwu/4CGfljYfZVfs8U00mq8cTDKPHScUTjPHW9k6ZTqzSUx4LcJ/rrYpeqlJ9TUiomdCZl1dgICj5Py2PuiEsKZoev8a19k82CAhCFLvf1ZJEBZLc4N4XDMFVwuyZzk0cN0+Gqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66946007)(6486002)(8936002)(6666004)(2906002)(7416002)(186003)(4326008)(33716001)(1076003)(5660300002)(33656002)(6916009)(44832011)(9686003)(6512007)(316002)(52116002)(508600001)(83380400001)(38100700002)(38350700002)(66556008)(6506007)(86362001)(66476007)(54906003)(26005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1irlz6rk/FxvDwkSmayBtGuRBHCGNPZsjRu2hXXqCVVTH97+psEeHiXEc/cx?=
 =?us-ascii?Q?7z/wlx2c8YkEPS30BmPpQf34lNE4vFovs6vjs00kRePGQKtmj9EA0YRaMyjT?=
 =?us-ascii?Q?B34J2gvF9CMVmwhb8WIyFKDpfW31mJ0YN6aDUT/V60SiUEv0jESTz6gRXdkF?=
 =?us-ascii?Q?byHlgGca25lWMbVY9yEYl1K0PHE4NZ/l1Yu8OWu8huA9a6yfzBZ6hrh40iPy?=
 =?us-ascii?Q?SWJrp421OhoxK4P6ZtjcnJFfss05MpEA8QnrRvWY4OocWnn1ElmVOGUz9KjJ?=
 =?us-ascii?Q?IslMSwE3IK+lNNrd14+W7Uue839tTpf2QyTn5QAAOL1KCr5LtcFV6XXKxhSy?=
 =?us-ascii?Q?d2fzDH1h13N860nf1zIEjTiNBlTvwjfVcQBm1AEgziwcnJBGk1chZomyO5Qt?=
 =?us-ascii?Q?rsq8d41r7up4MW+bwVQVA3QFaXYZ0NGd4UXIaRnzpaTH8NF7K4L6Pm1PU5zm?=
 =?us-ascii?Q?T16r1J8clTTWVBgDbds9IRtJSsCIGK3G6tPGHhkjLycQD54oYEutVHEtXB4z?=
 =?us-ascii?Q?8EH2ePcY5eqJT3ITsjrJtBdRzHU9n7pcgaxrCgKvHYr7pncAW5eRvgYqKCno?=
 =?us-ascii?Q?Nhhy1VCTwGd0uXi/KGIK5SwYdbXekJCffvffzMkx+Gt6d4ELTcthEfQnU8SW?=
 =?us-ascii?Q?Db91p+4eSeu5kvROsDcuuBR0OfyXdl8bfkEhmW8XOpqJbzcluxDTsv1fQlGI?=
 =?us-ascii?Q?fJZs8OU7iWF4LXQWnIGpSKPxDxZgJ38o/KE650Gg1J4f5dgiyezYSpwo4nCf?=
 =?us-ascii?Q?dR8G1xR56pRkxu96H7shtmUNYMFthW+jXwfUhl65g27xFtevbfYKtbSojzaq?=
 =?us-ascii?Q?zrFN2nFX/kPbZfxOg6FDML4pMewJy05kVHpIvUVnKEsjjgyVxML7vmubFC8s?=
 =?us-ascii?Q?MaNi3LGuTkseMZf5NYnS0sFXYQWoQl+tE92UM5IDPM16y9FAw5gZ8Sxc1Zg2?=
 =?us-ascii?Q?sQBl5Ir8+eUj0Ogx40HyAQRjiheeoiSZxSLPqHYsgFqDk39mt4Injj4ln3k0?=
 =?us-ascii?Q?CgcxfnHErcxDrKXT9ISATw63utxdQ9YSyPZLdekdLBFK96FfFzZD20vrNT/c?=
 =?us-ascii?Q?8kFwPmWEvrxnXCcUUvgkAr1NYEuRE0HmMjqWu5MHD/Kz13V4PV3RN/QnTeen?=
 =?us-ascii?Q?7PDW17qbx/8NYrIv0QJxffnXo/e8RdfWF8ocH/JyYuz2vE1tYawL3QAr1w0O?=
 =?us-ascii?Q?VHkHk/iDR5PxfXRGVZFrCV0tQwBUBLFkZN8x3FVz0zO8WcGBmwyjkxPip10x?=
 =?us-ascii?Q?k/htRetqi4ESQ0ZybWS6+9praeiCGTvLrH/WTDXGer93HC7cVl5P9jyfCw7g?=
 =?us-ascii?Q?1DhbTrDJbiCIloaK2XGxbS/ogAlxFLn7W2nPXOnUffsy5yQGEyCuGIPxdo3+?=
 =?us-ascii?Q?3rGvQKOt7Irr5GIX5d3+Autg9S7x5GRA2BnkTio7Qc9EyFB4SNmNOY41hauz?=
 =?us-ascii?Q?Wmzbs258jexKkMdTng/tXFK6gjo0pbGVGqZuL9nK2NSPvjJY5e4Vz58XiK4d?=
 =?us-ascii?Q?McxbWR12LvZtrqwhGbI7KzDX+olLtxpklCDjPB5qEbSvH4ZMkUy+/MSoF8e8?=
 =?us-ascii?Q?IO2AmjiTALEuAuxAnGh1TUJLK7LayVJXMd3Xsg7SlGII4VbKj9/rRPs1bLVw?=
 =?us-ascii?Q?fa1Xb4JrBjBdkDjUOKvbd7DN7csscsAzknicjn2Wwg4g1t1rMOUpJ2rI8kyQ?=
 =?us-ascii?Q?CetWPZm1eQT1YicQ1I+LbDW7AhM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d416287-513b-434c-2c16-08d9d1b06704
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:36:22.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhcMVHb9w60nTv/fP3vM3qKavqBW1/HRS7X04akIZ83kiJPPkHKhBdzbkKJIA9G7Mvq78sZVJktdNTp7Ata++/yeC1TC978N6D76R4T1SUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070053
X-Proofpoint-ORIG-GUID: xce09MwIYd2QMjqQ1wlrdNxo9H4WtWZC
X-Proofpoint-GUID: xce09MwIYd2QMjqQ1wlrdNxo9H4WtWZC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unfortunately this code has stumbled into some deep C standards
nonsense.  These two structs have a 3 byte struct hole at the end.  If
you partially initialize a struct then the C standard specifies that
all the struct holes are zeroed out.  But when you initialize all the
members of the struct, as this code does, then struct holes may be left
with uninitialized stack data.  This is from C11 section 6.7.9 and how
it is implemented in GCC.

Anyway, add some memsets to prevent exposing uninitialized stack data
with the user.  Debugfs is root only so the real life impact of these
leaks is very small.

Fixes: 1966a5078f2d ("mt76: mt7915: add mu-mimo and ofdma debugfs knobs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0911b6f973b5..19c340c65465 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2999,10 +2999,11 @@ int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enabled)
 	struct {
 		__le32 cmd;
 		u8 enable;
-	} data = {
-		.cmd = cpu_to_le32(MURU_SET_TXC_TX_STATS_EN),
-		.enable = enabled,
-	};
+	} data;
+
+	memset(&data, 0, sizeof(data));
+	data.cmd = cpu_to_le32(MURU_SET_TXC_TX_STATS_EN);
+	data.enable = enabled;
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL), &data,
 				sizeof(data), false);
@@ -3014,15 +3015,15 @@ int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms)
 	struct sk_buff *skb;
 	struct mt7915_mcu_muru_stats *mu_stats =
 				(struct mt7915_mcu_muru_stats *)ms;
-	int ret;
-
 	struct {
 		__le32 cmd;
 		u8 band_idx;
-	} req = {
-		.cmd = cpu_to_le32(MURU_GET_TXC_TX_STATS),
-		.band_idx = phy != &dev->phy,
-	};
+	} req;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	req.cmd = cpu_to_le32(MURU_GET_TXC_TX_STATS);
+	req.band_idx = phy != &dev->phy;
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL),
 					&req, sizeof(req), true, &skb);
-- 
2.20.1

