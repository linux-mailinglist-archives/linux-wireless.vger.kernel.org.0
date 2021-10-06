Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A91423907
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 09:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhJFHiE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 03:38:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48522 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237335AbhJFHiD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 03:38:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1966FZDO003372;
        Wed, 6 Oct 2021 07:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=96gGWQWVpvgVXjtBe8+QIJJrzrzH2F8eny4tpoYl/rA=;
 b=yxweAmSMJvmk7kU0NKqTt5nmxrCd0EBRI9t0R+PKBzgldFuXo+JAMb2/U9JX+5vL0q/1
 aKnNgGnrbNUGVS2jRcX5+hh/Q0JBdRb6H+Bhyk63zy2hNS70UPchEaS6rgc2NcRT69WV
 XH13lHh8h+8EfAO88j0QUSyZxHdvhd8feiG/uPsYmAne5aHn3MGMIbaz+RvyaSQg8IHD
 pOkWSWOWC7MhT4OTBl2OxTykTKFRyg5HiK2kiiezM/iqQ+4U7FMjKHyoKfUlb/rx8yBg
 gavRElTAjo/X4hZ3BJWyUvHr9GVIvRJD7Rwz3IFlPsZpRuoPCXqR53dVhPI9omEtYNjv VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh2dnhaup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 07:35:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1967Yjbi059089;
        Wed, 6 Oct 2021 07:35:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3bf16uhrn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 07:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdNs8cMbQp3kic/x3BNXjfwk/DTYgNjE6ORqIu67H3VyPWket/+JPhiznvP9BTo+biG04Qm6wOuQes+NkSujoPskF639OpwjZDHqY99h58xCKyoqxQwS+b9ZuXqlDXfuv/QLFsXgq4f9jzn+2pLoMzwyy26r4AJElbrB78280v2k66oswMjWsuMdvJ7pP+lg9lBQLRvTvZMTpSQcbAtoxSxrMtIZADjVMmhvkjux9vjw995x6kgqTHHTv2vVU7HmLcO728cKaHAa0jbeI/aKPuW+HI84gwMoyrEX/+6MBedAYpt26fsk6vzkgq+7+NF95XgbqDwo2OLa38yWlG3h+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96gGWQWVpvgVXjtBe8+QIJJrzrzH2F8eny4tpoYl/rA=;
 b=BG8d+FBwDgMRCo/sZtUY7TMu7xy9VI8eubyhK9rNTrWt7rmWLzd7ePJiS3cvXmWrcxgPbqiIyUCObdv3I3FsjEqCGTP9vxc5oXyAgzh+er4tSnOT/wGMJbhwrhaZvRHZgv2k4o+llevUNISQFVZN2q6zc3PheCIWbgiCpb2fqkaFN/yZM5mjf9AzY3CKL0ASboARqwrorqvacMTPzjzYYVwto8S2nrPgtFPr6zgWTS3ZUHGFYNm7KJZNDqpo59lBMxiRlW82nhp30KY9EXfUM52ZcKt7wYsB+klOqtQZOmY9DvLEljovQG822gp6NprTHuD4KTDvIPQsUKWjBu4JrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96gGWQWVpvgVXjtBe8+QIJJrzrzH2F8eny4tpoYl/rA=;
 b=YgZwE6JRGbYSSjN1JFARykS7PmXPzvoZZR7XMGYT5ogLsVllvh/od52N7a7eSO+ojjmttzZXYSu626GTjyDUrzxRqUkcARma7rOZ66s4ISxaV3+zYo+kF4URvE5WZUjbbOSVJT7yK8F/4btNMHA7CMPGJDzFrlJaJAaLUtv4nC4=
Authentication-Results: lwfinger.net; dkim=none (message not signed)
 header.d=none;lwfinger.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4546.namprd10.prod.outlook.com
 (2603:10b6:303:6e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 07:35:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 07:35:53 +0000
Date:   Wed, 6 Oct 2021 10:35:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] b43legacy: fix a lower bounds test
Message-ID: <20211006073542.GD8404@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZRAP278CA0007.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 6 Oct 2021 07:35:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4abeda4-e3fd-4aa1-f352-08d9889bed78
X-MS-TrafficTypeDiagnostic: CO1PR10MB4546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4546721850D033A16A9BB0738EB09@CO1PR10MB4546.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2mqalhbptgucy/mbj4eOi9csARKxviDTMi8ynLoSLK3NfpRlGp+FlLzwaTyyyrP1J/g7egUaq32790MPYX9/+2ygtqIZkhjNNKczc3PDKx5h34YilF7ZreU9epWy3V/Fwqqso5Bak2QfTooJYhSAy69VTRRS3NxneaCFdWAMP4DdIxef3a8LrJds00zAtHBiUqz0v+mpC8F0kBoMSeqvGxSrG46RnBsbFbLpF+JkghAa+kH79frigzoSWvEWsNkBlzgAvH8lbvVxu4+XOoXhiXCmCkiN702GiZvbudkPvCSb6xyPC0/VkUbkdNbJp8caDk21pzlhQr5xoXv7h4JNGo/kWDXanBZbBp5iWh9bQqKM30HBA4I4nicUuc544tnxKYXDr0oIqClRKrsWMu6GyGgKjcDY0lbH5LWp3GFoVb8OP3eA67wQUk88hgw3ATyCuIq5RH8T6U1MFcxGRUVTonhwrxQsiG+SnZLmskUIVPnTGQY7pY9aBW4GQzNHtof6iutKMjtvi7o6RPkKHikJwky1KluxULylchzDzkjqMfU6QkN86mY+MSW24FXSGN3bXqZlpRfL+m4RyrXTyZphCSexSBynCfUVB/G7lsg5Hj+rbGO67G7sf9SuCavB2mfOVy1t44ulFpWB6jh5APeqKlXcECzHxyaytlpr6IssO4WVoR6GmYrGWLSTI5kmga8Y7X7Ed3BbLBK7vu0j08xKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(86362001)(6916009)(33716001)(1076003)(26005)(508600001)(6666004)(44832011)(956004)(4326008)(186003)(2906002)(38350700002)(52116002)(9686003)(6496006)(66946007)(66476007)(66556008)(8676002)(316002)(8936002)(38100700002)(33656002)(55016002)(9576002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfXFERSX2KeInulu95v3e8zyo1nf2yjpkD6RDxKSdIqnGXQniGnMzMs0uy4J?=
 =?us-ascii?Q?mg6m2+3TZlPeOiykYi14IW48X93CZHCkiKVht3LE/1ryrafZhy3gAuuWd8e9?=
 =?us-ascii?Q?ELGR9/RnTsBsREwIT96ay19Mp3Otv264eCTlfoDzRkut0rN7w0efqfAZF+fP?=
 =?us-ascii?Q?Oo5i2lj3rS7dy7M/p/2DqONsGjAwwJ/mLpanDsxFJKZjNqUjoWfWcymunyJD?=
 =?us-ascii?Q?fxxR+1Euj7AbxQzMOSD2A8YA4PyuNe8+9w9wWI5p1hs8hgyPuIPY2yHtUbJX?=
 =?us-ascii?Q?mPapjdFcxRyyrVVd3u3il/HGnB+YKwaj+Fge2LvM88IhDZtvptkw3zhgwGzH?=
 =?us-ascii?Q?Cxpc75BHp4gsA5vZ4A8cFmALvQLNZUOETV9P7gIfn12KtyI2ezpx+tA8wYhz?=
 =?us-ascii?Q?opjwatMsWKqu4uTqm6ANe9vFKXNxnDAn9U3d4cQS6/uNTalG3hQFt8ZLhfm6?=
 =?us-ascii?Q?nnQX+9wzRUImUH2sUsz36ezcl/xX3wZGr32QVrGnqIl3DBnnFNKei0LYZKEW?=
 =?us-ascii?Q?EWV4iRHNLt27eHRIhPHL+ZS/lFywWOpOfEZwWIU9DY2zb+dSfKpBoQJliTV3?=
 =?us-ascii?Q?Uk9vywHEXYqzZADYzGfAuEuQ5DbKTbuRNKig8cU2CWd9iWqJq0eVIv+40oW/?=
 =?us-ascii?Q?J/uT2CSj3S0kMze2P2hXSYXZBnc3wHQ8PnQ0nH7ohDbFY3c0eMr5UQgZBJmH?=
 =?us-ascii?Q?Axuj6KPkWb6PVP5dvEhJdVoyrMP4bzgtw6uRmdF1e3uY60QWNGP1x9bAWVjR?=
 =?us-ascii?Q?YvXdp+NaQ6Yyyp+MPckFUyxcFK7w3CAC0BfMrJbewPoejNXwcxBMJSTpQ725?=
 =?us-ascii?Q?kVbv5HztV8A1tPadK/9JfsyLarhbhdB9T7X0RJTJ0SgGe1cJ2Rp9T2m9Z0bR?=
 =?us-ascii?Q?PENMqVFnkPzC1MYcNR/SO5px5r+d3Wc8Aa7pvlSQlN2AxXWSh15Ln8gMtX3i?=
 =?us-ascii?Q?wGc2m2TbiVPiiZvHSaeMRZTZXlbKwJC5FcfcUlCR/YEmdloW174kbMzN25ry?=
 =?us-ascii?Q?wxaTojOYCH6Z363WSv8B3/PgWBDm+7rdhhPtGHQ61MIlkyYJuoT+HpRuneJh?=
 =?us-ascii?Q?eLaMNGKdqcTq3ZpDkfhxJ9Mp9qnTBAvj6eK4FXgolbXY405OUFjdddGEe5Me?=
 =?us-ascii?Q?cVCptFf22kF22pcs68IVNX07haN8dAAQiv5O1mxuM08KvBCHY9VYaoIW0IC0?=
 =?us-ascii?Q?nU3URUCIUyKV/ozic8p+UQ8mZA4eGlwprdtNYeTTOQmiMs706ZPoGGpW6Vgn?=
 =?us-ascii?Q?8nTH0i1cSI/Q9uOKV6rteuzk9E8MeUQJGe6PeIj/6VZ7f0hn/LjZxebK0Dxx?=
 =?us-ascii?Q?syC0Y6d8tFnn3CiACpibCuej?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4abeda4-e3fd-4aa1-f352-08d9889bed78
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 07:35:53.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvQw3Nn9zei0eZaeI4kW50pO4dfm/W2G/fYXhqwUvtferPNVtl58oV3saFNhqBl1wZn4lHv3oscyppDKE7r2D/vRagBM8mxRclDSSDFICj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060047
X-Proofpoint-ORIG-GUID: X4bQUUsQEeSlARoUhxY49asyD6mNSQQ2
X-Proofpoint-GUID: X4bQUUsQEeSlARoUhxY49asyD6mNSQQ2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The problem is that "channel" is an unsigned int, when it's less 5 the
value of "channel - 5" is not a negative number as one would expect but
is very high positive value instead.

This means that "start" becomes a very high positive value.  The result
of that is that we never enter the "for (i = start; i <= end; i++) {"
loop.  Instead of storing the result from b43legacy_radio_aci_detect()
it just uses zero.

Fixes: 75388acd0cd8 ("[B43LEGACY]: add mac80211-based driver for legacy BCM43xx devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This fix is correct, but making dead code go live can sometimes expose
bugs which were previously hiding and is always carries a slight risk.

 drivers/net/wireless/broadcom/b43legacy/radio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/radio.c b/drivers/net/wireless/broadcom/b43legacy/radio.c
index 06891b4f837b..fdf78c10a05c 100644
--- a/drivers/net/wireless/broadcom/b43legacy/radio.c
+++ b/drivers/net/wireless/broadcom/b43legacy/radio.c
@@ -283,7 +283,7 @@ u8 b43legacy_radio_aci_scan(struct b43legacy_wldev *dev)
 			    & 0x7FFF);
 	b43legacy_set_all_gains(dev, 3, 8, 1);
 
-	start = (channel - 5 > 0) ? channel - 5 : 1;
+	start = (channel > 5) ? channel - 5 : 1;
 	end = (channel + 5 < 14) ? channel + 5 : 13;
 
 	for (i = start; i <= end; i++) {
-- 
2.20.1

