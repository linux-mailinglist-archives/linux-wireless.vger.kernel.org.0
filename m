Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0916403A62
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhIHNOg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 09:14:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43144 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233810AbhIHNOg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 09:14:36 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188AN7Ka010809;
        Wed, 8 Sep 2021 13:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mJUfToBJKsf1P1I8ZNgKMNINQoIxb1STEr/zUr11KTg=;
 b=lOXJdHP2E9HwFjPWPzRGYfPGjRFXlfl2XtJFPQU59d3O3LgoiPEEeL72P00oVbZBOosk
 o3Y0O9c32xeMIjm+TIaJos+boZjS8Z65qZwd2xvuZcRWv1MFeDkydJW8FUep/tR3u4xn
 WywKaI/DrcGjliqqcg/s8Ij/f45CK3UWnVhNBFPW4bft3xoMzNGUB7oE1CJtjDkSkBPv
 gRJGZr+py8dcmvCGEmV4GGGK4PYwoqnGyQeHKfGk/EPw834w2ocp3o8t3HDQG/vHbX5O
 rhb5F8GPC7O+27rA3AkAJT4rvaYSgwbU+6JMimAZyw8eDDuK1zfzD2jJIgCK5TfpAkWX dQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=mJUfToBJKsf1P1I8ZNgKMNINQoIxb1STEr/zUr11KTg=;
 b=dwWbYRYDsMsAjNYCeWAer5PO7ktZlpsL978xq/dHpKUR6D/hhGOZRv7+dCpbPGhudkB4
 AqF6kQZMtOHoM2q9t1PZ7+8FsI3yMcM+FfzsWP4mqGGkRc0Pd5E9EgPFqaHDGflwUTKQ
 pQwA3QEDit36BkmkvQFLettJWtCVE3wWveHoW7SzODTEys+5ANZnrKZQ/PyHUaug+8S2
 +mck5VhJyHQAs2qVrgD0HkTHvXOb2sOjV1ol16oJxhdY5GI617ww05C+yaYeeHTXNKMb
 QN1j9jhR/fGPBQ8NLJVX9/O57jVeBJbcuX8lFaUKHRIpTxyBBhcHftg8XQMlOeo+Hcxa 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw6anj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 13:13:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188DADRk074840;
        Wed, 8 Sep 2021 13:13:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 3axcpnqfhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 13:13:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFf9n9g/XENvVmcrDJuyuL2VuhvAKNDZbyYWKf89sBeE3NzH0R+5Bc2SvXbOkX0u0nBc0Gv0yYPtpMVzhx/2WP8S1rI21RF5V7lXi5CAKxLBJe1/BCYjYaDJNjBMvXlOXbaRW7BTefyYnlp8BkWMyR7fBv61jdxT+53g+RhRCLdZMWOAAjtNXHuOHeeIE4aJaRcdFYImtFKNfRxt6zweczLmQ4JtTedgzt6nTcJZGvVE8/7siC3kUi2kK/dzmevTLsVF426x637MWYW528J/s67+yBas/WxCaGqepVQ0cj5UTVTomprX6s38/h9Kdo8swShKZbd4sGAjHuRWa+klzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mJUfToBJKsf1P1I8ZNgKMNINQoIxb1STEr/zUr11KTg=;
 b=YRBXoeiBqQfozCeWz/xfxUQkbqU94nSwf9VlX2RjuD8yai1rAdxjvWG9otXflM0XRBA66bkEG6QLoz4JeRVrMuNbW8x3ebMvNYnSNiZ74KYi3V1eKMjIrBSKwbLN34NxlljOku7kRacO0O0AGL7/0sEJO11i5u3B0CntiS5U4RY5bedOGl5kuVJKJ+OojusarWqbnXhhikBBmAyUaR5CdbTWAMiY17lMiR8YcXb6r21Y6itHUUS9XZcBfH5nkHp7TE/R0YO9CkWeyPQglJQJal/yVXbxZzQtqKHvPx1rPrbtLAPWHqj2hNdkTCKz1SerEiV1FBjhX4mmRWcYvapbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJUfToBJKsf1P1I8ZNgKMNINQoIxb1STEr/zUr11KTg=;
 b=QH4AUlVkXvUsiOB/9sZaFp9rN3SsCvc29DjWyJVVtvFCYi0e5GfQP6yfLG1Ybxt3Iq2lKAUPCrdRFtqofR/Mn8YxQz5rwJh1s7MUJElaoqxr9hYGsdR/VAWOZ5GGJCDH4HJ0QQtYsb5/ccnp7W4VaN4Q120cGsRTXJu1f7AAhYA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1661.namprd10.prod.outlook.com
 (2603:10b6:301:8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Wed, 8 Sep
 2021 13:13:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 13:13:14 +0000
Date:   Wed, 8 Sep 2021 16:12:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] brcmfmac: fix "board_type" in brcmf_of_probe()
Message-ID: <20210908131254.GJ1935@kadam>
References: <YNCHELb14+eNV94n@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCHELb14+eNV94n@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 13:13:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e0751c2-2ea4-448f-24e4-08d972ca6a8c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1661:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB16612ABE5E4B1C74DE27C4798ED49@MWHPR10MB1661.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FOa+uC/VQ4AskTIbAaVxRRmNjWiKveVaZKLWAzTc1pXAjy9q9yw/UAJE1MWPrdyR3sV/89xiheUDd+sYJq6aM68Vsqkxg9a6T/D+Ot6S20ji023/JtFH/wOyPZyzZcMMWeJ6tMBStQRR236p7KavEUnbyAoPgjHT5o/f6GUDk9fYCLFpb3HjW8K0CC9hnb78tUfXyx97bJGncmpybWmZMSbRMsG1Nc0dkJYh4Zt50NI4mQvdbxaJ7juayk6A42MLbjip8fExEL9QDZmLscl3oDymxBIpJXSlB8uOl+ZfzcUhcN4srBxupTzoIyZhxwecbL/1HTub0D51/sDipUeTmc3Ah8k7/1WsZeZggcwOg8eOO6WVsqxvnoYBflxM9OxAuQMyQBoIML5iZXTcINvh/ZbcAw6p33nmKi1AvoU9dpgQC6KLPyAIIZssRjSsXrLLpzwpPSoBWjb78mgQE93Ql9K0L7wF1xayMAzkbjuSd68SC8LFnmHf5+gqdKRVYvahBNm2wlH23UCk9bi7HFw4abaIC4vBN8rxAFreSaMKxrEOFl8e+a2qgyKkewE88d1OxO8cCxA7MtFILS57vQ10exqYFY0hyfMfHK10bAj80C5DqRHyaR3qbUlb5HKKwNFT+NYtOeI+ppDfEOWGiosTKcTDaGG76PVwjJvAtazMSL7ZkPaDstzBRkpYhPdczeomVwoii1054uqcTvad/8FrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(366004)(136003)(7416002)(2906002)(186003)(316002)(38350700002)(66476007)(38100700002)(956004)(6496006)(4326008)(54906003)(66946007)(110136005)(26005)(33716001)(44832011)(52116002)(478600001)(86362001)(55016002)(5660300002)(1076003)(6666004)(8936002)(83380400001)(33656002)(9686003)(9576002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fCtO43JJS8SPbrorD053eZ+tbGMwpJW+eB6Tsi4R4kOJaEiS9EZA/qsCkEPm?=
 =?us-ascii?Q?L6eM/mIbXgCeXtrZ0aAWL1bauKa/wKTtZoJrl4cns82/GVcLR5fSoVeu4qot?=
 =?us-ascii?Q?PtltxvruOmoWBscR6NcJbM1g2B0+h1Grg+e7MNLy1JNYb8oW1o1XD8kQpXOn?=
 =?us-ascii?Q?QpvmBnc3gOI1j1JJGifODbd1MQYr8G+0nLfcss9UlMGWjyXRkdAJzQ/Szwly?=
 =?us-ascii?Q?vEslgL9x3oZOeoTusJTuc2gAN9GWQkM1F9dvSTbf3ChmDHtSOAeXDpcezRvI?=
 =?us-ascii?Q?9/QwUmmX57ZqWFkMaLUVUEsOzCSXrC2EkLGw1IbetgVQgzrkFnQ5jQFIkWf2?=
 =?us-ascii?Q?G9Wnr1b2LmcFLaSNgHOgF8+TRB7rtOLm9Jm46xa2VYcW5D751NYdl7964gO6?=
 =?us-ascii?Q?iVCJAAhqzkkTrr4mA04pD9kaZu3MYnd4IVcmN4H8/4MnW57XiegLzO3Vu1lV?=
 =?us-ascii?Q?Ky0dfWxsfpWVwGLf9rnRstJoW5YHREOGO9aQd1ftYFgjqAf4/PEkd38EYXai?=
 =?us-ascii?Q?SpCAF5nffq4ZlToVfL8zYqxKiOlkvnLuU/k2JXz+w8lkW4jH5zjQY3w//8bz?=
 =?us-ascii?Q?GyWVe2eW9e2DBJF2Wop7+9N8prufGkNlMj9wv5eKgmhGCrj1ebQMLkMK/UDb?=
 =?us-ascii?Q?hZgVqD+gpjmkDvCSGAR95+bHMMVHpRHB1aKQwEDROlnvNgxQ+MrJqjTQ0YIo?=
 =?us-ascii?Q?j/KtpIYaoyn4b/ZQ0GNHGuryxQb8qrGVeXqic9d8V/QgSJRUBYv1qKJ+8IMF?=
 =?us-ascii?Q?x1T118Z/grLB4qEzsxJE6H8yuAEhBXFDKiyeS/PlB4BpbqWbWJHvafbq5xZa?=
 =?us-ascii?Q?TIAF6lNcRPeFDgt2hRsfIK0njKZdRPRITFTt7Yo8JfvplxqNPBnGJ5QZ07FQ?=
 =?us-ascii?Q?xJ56QhrWG7M5+6UDJWHmJBCJ/RpXtgVkyf0jPKngiQZhdx24dnqiNdXUds1L?=
 =?us-ascii?Q?gCgK+Z+HrMwtiU2vbVvcAAqNt0w53Uf//2HTb1o/Pkb6j6R6vp4oEjCsPO6m?=
 =?us-ascii?Q?JEw4E7BtxoGLIFAD8uZik3jtH76evGyF+QmfZHhuX6F81DUgq5UntOeiDmGK?=
 =?us-ascii?Q?ixcKEvQoPnEgc4MQ2CqG/tlaOdNgTX3Ew6n19f7H0n69phTHIMiaYREQbxF6?=
 =?us-ascii?Q?pYaZP9H4HJ6m7chtxEWVvZoYytEQdPVeQEhHwdoq6SdO65PFtBXNjCMFWIEW?=
 =?us-ascii?Q?QCgmGQtAB/1z/9nwZm3htqWyeoAdlaVQR7R8gvmLFi3rLp0DNo2/yDqRSWna?=
 =?us-ascii?Q?h0DrDh68jiFNBk+tjIAYPNjCQkBnuZcNUJ/pxEKGRVZwLopST7V8wMCcgSgG?=
 =?us-ascii?Q?iE80AtjtehSNam5bJi30W4yY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0751c2-2ea4-448f-24e4-08d972ca6a8c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 13:13:14.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1uxL/xBwdLQXS8EC7C7kMidN7e2CF0iqC9S+PoQ7+0dlSJ2hTzXUqG35SaLg66VPNwoG3BMnUhz8u7HNWhzj2Fi9xE2DyWOje5NuxJVQfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1661
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080085
X-Proofpoint-GUID: LaG7XhL3a-3t0KttQ6UBsKg2rs0Jmqaa
X-Proofpoint-ORIG-GUID: LaG7XhL3a-3t0KttQ6UBsKg2rs0Jmqaa
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is still needed.

regards,
dan carpenter


On Tue, Jun 22, 2021 at 01:46:55PM +0300, Dan Carpenter wrote:
> There are two bugs here:
> 1) devm_kzalloc() needs to be checked for allocation errors.
> 2) The loop was intended to be:
> 
>  Bad:	for (i = 0; i < board_type[i]; i++) {
> Good:	for (i = 0; i < len; i++) {
> 
> Neither of these bugs are likely to cause an issue in practice but
> they're worth fixing.  Also the code could be made simpler by using the
> devm_kstrdup() and strreplace() functions.
> 
> Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reported-by: Hans deGoede <hdegoede@redhat.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Basically a completely different patch.  :)
> v3: Add missing of_node_put() caught by Hans de Goede
> 
>  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index a7554265f95f..dee3d968e49b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -24,20 +24,18 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>  	/* Set board-type to the first string of the machine compatible prop */
>  	root = of_find_node_by_path("/");
>  	if (root) {
> -		int i, len;
>  		char *board_type;
>  		const char *tmp;
>  
>  		of_property_read_string_index(root, "compatible", 0, &tmp);
>  
>  		/* get rid of '/' in the compatible string to be able to find the FW */
> -		len = strlen(tmp) + 1;
> -		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> -		strscpy(board_type, tmp, len);
> -		for (i = 0; i < board_type[i]; i++) {
> -			if (board_type[i] == '/')
> -				board_type[i] = '-';
> +		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
> +		if (!board_type) {
> +			of_node_put(root);
> +			return;
>  		}
> +		strreplace(board_type, '/', '-');
>  		settings->board_type = board_type;
>  
>  		of_node_put(root);
> -- 
> 2.30.2
