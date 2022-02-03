Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDED04A8043
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 09:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbiBCIW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 03:22:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39282 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbiBCIW0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 03:22:26 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2136Kt1s023469;
        Thu, 3 Feb 2022 08:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=kffiubo6ZaGNu6FUeBbFxywGrOhNcLmCBV8S7ktH9Kk=;
 b=072Vdmv5oSI4SbDm9FF/u24XOpzKz+4II9tkS6IUjcJVOVNRUI6YGJkaYzemuscI+1Vk
 qhwgc4o/JbQa3kwXY3+z7XCRnzYr4yfGUnoQhJ6xL91ttFBqYarsyevOCZrQ//IYAUwb
 o91HcYXksLfp9IIdsB9bzR/Iaq8g0QUwii2lE87o8mMv/QrX4m4kYKlXcJlvdQhNisAP
 JUhBCBEjMtKZc/U7d2FoQeUlT010GxHGzneGRVBtebseUoIfh6YDTR0z4ctA0L3XnJ9y
 WPHHdH7jAxRHcgGzpAkfkBPWsApFzK2wV0AzKFqcKBNsKNNXNrNgpU2c2H5LSRuYCa9O og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2r843-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 08:22:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2138LTLQ188561;
        Thu, 3 Feb 2022 08:22:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3dvtq4hf6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 08:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMbR5TWjszj8HDwOv7xl5Z9p2c3X0bJnyovPWzNSeL+NHH+qvi+xnRIt6u0xm0nzhsM4gmrMYe7JoUtnViwWUEhSv+bSxhqx7chvv2esG1wYjS4NWIhTR9vxH/M8x6QXn3Wls24ypQpjZx73YMyWEE3NEGX4dinYmGDRjlsr+wyPuq7TATc5DMm/X5uRzNdWtbQ5vG3WxI769HzuzHYKQNPbwj49gagGWzQNokwq9oHyBCLOWpPx0gzpSVEHezkh3b6QjPGb0GbuvfNmALbAL/XWfpJA1uRZeTfzV1R3HnHHWX6AbxZBGcz4zfdEDra2CZ/RjO4Ej9yHk51BChZVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kffiubo6ZaGNu6FUeBbFxywGrOhNcLmCBV8S7ktH9Kk=;
 b=HWedk6qutpGP9OvoHLyqA7eeqaQGpkJYTbX/AZR6q9ZIEmUY1RA7jsfAm3tk5bRhiqDfNPcc42VGOCXuzc+/02PDobQSCAuq943/rojwCI3wFWDMVVueZFXVwbtGO97Zr/+wIZTw+0guWtzvYn5iGQXrxpLOPay4atTtRq4wZbimaeMY5oXG+lCg0aP8pDN1Mxjwlo28NW3Gx1do/DHAsK4e8MUy/ycXnPjkHxWgoNzekYZd/i2mv1x9U7KRA3RNiU4cxMy5zyUCzeZ+egaJT+/BSTcXke3jqCCCcyy9V7KThGWjcmDDp7gf1EviD7WEjPPQCCFnjyB7lIXvX7JvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kffiubo6ZaGNu6FUeBbFxywGrOhNcLmCBV8S7ktH9Kk=;
 b=gQiRP7K+waaZI/3dAt/xvCSwhy0cmEbK+z63jz5jzqk+88e6z0QooooFMCI90Z/BVX+6q+f1PvByWsRXWZoknXHlAMTsJCmUsLVEfAkdWXzj9URIGc7Th0umgkC4rCbnOcfxtppKnp8YWQG9CHRx9HqKwqL9ciw4fjgvtuvee2g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3226.namprd10.prod.outlook.com
 (2603:10b6:5:1a4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 08:22:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Thu, 3 Feb 2022
 08:22:15 +0000
Date:   Thu, 3 Feb 2022 11:22:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pkshih <pkshih@realtek.com>
Cc:     Bernie Huang <phhuang@realtek.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] rtw88: fix use after free in
 rtw_hw_scan_update_probe_req()
Message-ID: <20220203082205.GD1978@kadam>
References: <20220202130510.GA27283@kili>
 <2bf144b4f5782c7909f783a0c5deb15e6186f032.camel@realtek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf144b4f5782c7909f783a0c5deb15e6186f032.camel@realtek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4e104d9-d54d-4514-a0e7-08d9e6ee4911
X-MS-TrafficTypeDiagnostic: DM6PR10MB3226:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB32265B7CECE0BFCAD59061CC8E289@DM6PR10MB3226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRQE8TMUmo4hhGq+xhPCmAHUkFG6B9V2BDeIciSFcZAd0cKZsaSoPSxHhO0pLiOKwRF0GfrDr2iyzuTweKMB4R12voHUNxIy4LUtDHrztExxLikx1FRLxd9FfloQIPigjPmxzG5KoI2bOCmLK+oPkzThdJuI9regaNGT6GNnDBM8CNwzy4z0Fs/sucJBLIKSwEW86DxcPO8FYkTh1u+gtiJUorcQ1UwOAJa+uVtCIozuyz8EKqxmXH5nHDnAeNwDKTZO46GTI5sYrszg492tmunnuLN+FEtDoAmbV+JnBtV2/OicOXIJy6xIkWDoYvr2LaoOCIXihW4c78b8nHYG28O2LDjRbJdP2/IBUmdG8EET/1kWgL1vhrw15rw/0vPejLxoYRvN6UFg43HxaNo4RokcBLJLK8Ghbumkc2zhHeU+wrSUu5rfbbhtF/q4q35gT65oMAyH+IUgF/mYkjMdMlsS7n74cxbGbdk/QMvgdcWrG+37LVqc2kx1Rs62uoOM6nQcuYk4vWWMP036/C1nrMRE93sMfzJO2V0pcmq/l5fC167FErxypYzgMhA6p0/2uMgMc4o7v1DtkMB8QOp9mz7l3NA/NBAJjC6AW/UFyTLbMtGhsg6nxnh+vWaOldMHG+FORbLbCVKWlckc++j7p2DJQ+P4n5M/TGnC5THebFcyftSrQP44o+ZMbTzItzfNqzm8uxU1wJxCcYXQ9OVCMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(26005)(1076003)(186003)(66556008)(8936002)(8676002)(4326008)(66476007)(66946007)(54906003)(6916009)(33656002)(316002)(6512007)(6506007)(44832011)(5660300002)(6486002)(52116002)(508600001)(2906002)(9686003)(86362001)(38350700002)(33716001)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sITR321E28pRkPQ6blgxrHqneE9QVbTUMMW3g6M5auP242wIERou7PyHFsGs?=
 =?us-ascii?Q?I5XQdvKNcohp6tq+evynlaRI6mo4I8k59Jjh1t+xGHVN0brcHuEayyj1FmQ5?=
 =?us-ascii?Q?4bA3Em0qXCwW+BHzp7xNpzPQ05PtlfK2FfxbrqGCdbre0k2nvtav9uw0b3Av?=
 =?us-ascii?Q?W0xI3Q/GpfF5XFIGQPzONziPQRVaXZMuv1br+nt2EVnwHBuaqsTgp+Sl0jic?=
 =?us-ascii?Q?Q9t0SASVRCixOqgwWtK1SUNQ5XG23iGuHzIuOKg0f/LXRGgTpq+8LV/+4d3F?=
 =?us-ascii?Q?BI82xsv3THp/3B3iDhFS6AxfCME2sskLyZ7UMJhu1z5L89eI11A4riVmxGjC?=
 =?us-ascii?Q?HANSRb13NGVC1XCQ5omM1EYY+6hzPEI312vyn7r8nBROcp2W5uVoaaqVkL5U?=
 =?us-ascii?Q?gZp92RktMKEKGTR8LD0DbmfyGAvDyvTLqcO16z6T+UXmBDcMqyW/ipzCyKQ6?=
 =?us-ascii?Q?WDCkf+2XFWX82LU3CQs+lDRYlVp/SjIN2QnHcQY6lhC4OPGCejRTt6K7pvDK?=
 =?us-ascii?Q?AumZImQmXPGeZTAMzMcv63MhieIvoJ8s2MnQhAsEr3LW2RwUl2+tj85lDcSf?=
 =?us-ascii?Q?+aEOMgJqoizqbszT7u1umbTToUjNvgDLnNbBMRDM3u5vtHpOMx9zcBq9lXTg?=
 =?us-ascii?Q?KuhFelieOeEw/ObGrGpTRf4G3s9N4UzsVlF9RCUW2IfOMMDAYnjkgkKyRHtF?=
 =?us-ascii?Q?eNFgoc92IpDbviwqusk6Q/OLtQ7Sp6VSqJHr1HhK5XkWdMXKg3pYcvnQGwKM?=
 =?us-ascii?Q?bChzXGhoYdUfRnc+y5vHfXzBUEmLDAgFiVts7WCMUQ/Fuv7m461kF0RAZon/?=
 =?us-ascii?Q?Swfh982Wsai/4mxobRdT7TdJ7MRKTnmfLgxBcqkAZrcubE9JcGeBQZ8kjL4R?=
 =?us-ascii?Q?zCWVJ/P4SGKeDscDxc3keKO3mnYucanjC/ecUOwP41Wccz0kjka8hdc/rMxd?=
 =?us-ascii?Q?c9elMlkAjvR5cpGulFcMcMOBSsKdjQ6J2898Er/CgZBjq5WTpUIJOiKHdoPW?=
 =?us-ascii?Q?V3dc4o3Oo2IhCLZuz99GedDiCsJ9XzZ0UY9uxTjbV0hGFOMms4xaBSnErzXg?=
 =?us-ascii?Q?yuReUyZp/lI/of6uXRZEzXtikuU7IDEsVIbp/3WBSZmg4x3KbuJDv1JRWTU7?=
 =?us-ascii?Q?LCRj3WgKtks1fWB0WazEaq7HHZIytRKjmvRGwrR+ruG26MaNpjalIefoPWvv?=
 =?us-ascii?Q?ZkVrzE5SYBEdJhjWHmSWdoOj2ihUCbrODrQaucWw+eVnwddnGFuIAUijh5Ce?=
 =?us-ascii?Q?mQEtB9+/4r5eeF7SvVhgNlEUYS4mwTJ3ZSCeq4G48rmK6v/uL3w4YBzBNhLD?=
 =?us-ascii?Q?fzYUDLpB5em4R7bPW7AisoS6nTG4Gprka881yKkZlx/GOq8LLqrI1+Aba4jq?=
 =?us-ascii?Q?FKllL6JxkC/pSXlxu88jcXZojiUPSA7woRmRMasobFzQFwfrI/ldF6inDL2L?=
 =?us-ascii?Q?sy105C6dUWQjAzpO++G6N/VX7Wgz3M6iAIjHuqzsUbO3IQ0p9dtK8QmEFbxI?=
 =?us-ascii?Q?W4KfP04YarMjKu6T5g4v0NC3YiNunVO8RTzCvNI7R/CLo/ojlHnWFCrzTxZn?=
 =?us-ascii?Q?oIb55JsiAX6TId/T8FaSv9KEuQqmILMdZPocUIYeljI9DYOdqxiCp3PoyDYp?=
 =?us-ascii?Q?+Qzn9D9m8Juci0qRNC3YT9Sei2LW1KoL9g+ru+MxaXWC7QqmHLvwu0UzJwjZ?=
 =?us-ascii?Q?qIPYBUK45874YPSUmPL1+wjyQUc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e104d9-d54d-4514-a0e7-08d9e6ee4911
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 08:22:15.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sx5Cdq7fMbL2YOLkOMmKR93LD0wQIMwsNgTCSvlq7MBOfbwAu5ITnaMnRaenrTGFBPMhT2lSC19izVhe06JNiXW9uA6kI3HNXUv7+oYK8qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030050
X-Proofpoint-GUID: 2NBr9a3T6VVlnnX4qJSrQ5qfUvJJt3Aq
X-Proofpoint-ORIG-GUID: 2NBr9a3T6VVlnnX4qJSrQ5qfUvJJt3Aq
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 03, 2022 at 07:59:47AM +0000, Pkshih wrote:
> On Wed, 2022-02-02 at 16:05 +0300, Dan Carpenter wrote:
> > This code needs to use skb_queue_walk_safe() instead of skb_queue_walk()
> > because it frees the list iterator.
> > 
> > Fixes: d95984b5580d ("rtw88: fix memory overrun and memory leak during hw_scan")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/fw.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
> > index ce9535cce723..2de0bb67bac6 100644
> > --- a/drivers/net/wireless/realtek/rtw88/fw.c
> > +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> > @@ -1864,7 +1864,7 @@ static int rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev,
> >  {
> >  	struct cfg80211_scan_request *req = rtwvif->scan_req;
> >  	struct sk_buff_head list;
> > -	struct sk_buff *skb;
> > +	struct sk_buff *skb, *tmp;
> >  	u8 num = req->n_ssids, i, bands = 0;
> >  	int ret;
> >  
> > @@ -1889,7 +1889,7 @@ static int rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev,
> >  	return _rtw_hw_scan_update_probe_req(rtwdev, num * bands, &list);
> >  
> >  out:
> > -	skb_queue_walk(&list, skb)
> > +	skb_queue_walk_safe(&list, skb, tmp)
> >  		kfree_skb(skb);
> >  
> >  	return ret;
> 
> 
> Oops, when I reivewed the patch "rtw88: fix memory overrun and memory leak during hw_scan", 
> I did only focus on pointers of list head, but forget skb is freed that leads use after free.
> 
> Could I have related fix with this patch?
> 

Yes, thank you for noticing that.  For some reason, on my system, Smatch
thinks that probe_req_list is always empty and doesn't warn about that
one because "it's impossible".

I will send a v2 patch.

regards,
dan carpenter

