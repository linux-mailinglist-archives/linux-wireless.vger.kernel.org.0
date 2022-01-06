Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6F44860ED
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jan 2022 08:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiAFHSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 02:18:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32496 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234429AbiAFHSg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 02:18:36 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2064d5d2006784;
        Thu, 6 Jan 2022 07:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=bESyrvLSbl2EjXMq9QRKqs2V1dAbQeggMoJE7n0xMW0=;
 b=Y45AP1WfhrHx76hfhVoO8xz/vfBAaJwwI1WF0lucUQp0KbhJVa/H7fy70SfupqiewHsQ
 C/oRE5ajvUtrpbV7u2tL1zxyeSPaZKYbSun1d+kJ0cbr0+5hFC5MowZ4qjBJoV51YOFq
 FjJxVIHliECmvTSzR1Vz9MQVaV3V8AFHnv7lPJUAVZvufTl5w/mcD/+85uCjGaE6vtAa
 QLa4Fzm1/JjYJAwe5Dnplf/DMYhkro44A+Aij7XfOTE8ak9ZLIpfsT7iR43vUrZzyWE6
 5kW08iUPTqmibCy09E/J7+3YRGW/BRXGkxvG78KdKzoCWhY5dRDZbSK2pIA9bsMu0WW1 cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpm0t4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 07:18:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2067Bpln159975;
        Thu, 6 Jan 2022 07:18:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3030.oracle.com with ESMTP id 3ddmqca943-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 07:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZorFhRy2qknD7KRpDlM0b1RP4SwyQqHsl4neYRZDIo0ykj4/FrsTGen8XmHIVfoaN2v34/OP9QAAzt21LhQYRm2LwOoo29KZmg83S+IUF4G8rjTBvyZlGxHZNa19aSOvl42HhFrAdNb/N1kGK4Bjbvx+zUpUCFxZ++L8tkV4lDqqrdbe7qK4Xw1SF309ndO/FCbqEkBa5JVmYdRRh3PVUz9rWEzG5cb9umz1XfK6bl6PgWX8fPOXHXlc/bBlYcATylfx/G0f8iHFXjXPnGJrbxuh7Ni4pStvtyLx4bBT5Vcw6R8Z8k3aY8Pvq2CyYE7jCUUXp+f45URzCaX6HJYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bESyrvLSbl2EjXMq9QRKqs2V1dAbQeggMoJE7n0xMW0=;
 b=aHk6XmhA34xVSId3RrchJkxYA1v01+ZRu67UHMvSu0M2i1sCzD1TUguB9W2UcOzz1WnxGfzKD6j5/v2SKJ4bOORcIIyMEmLVqjtAK87grAsM/KuHKIY1Rh+m2mS3AFMFgi5rNB9F9CBbXLo8Ja1m4NoHnb62Vl5F4uJ2gBRcG/9H6lNKjTzKc5Ur3gvPpYNGjS7oDRYNfkIuGi83wysmB/kP2LhKUFJXfLFCStVSPIvpES6luE1MkD+2Bl+wwESaL+dStMqcq8vZpAW5Nu6wV2BtGOIYCscIp5pQPKE3txsYS6NItwMVnvZw94yXXHNFfaLcCfysqZG/i3rAqnSQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bESyrvLSbl2EjXMq9QRKqs2V1dAbQeggMoJE7n0xMW0=;
 b=bMRVOtty54nDaT9zu6ypi4TE3aR+l2Dj5t8v13evajWBHSQPBLSC+fOBf9AV7c0LBQHFW9KaRvspZ0dBfvv8lKwmObJPGnaa6pMV8zXJEi904FapUHxU/MwFjjZL9l+63t7M5hay/7X/HN19Na11SIMzL2A6rVwuY4fhY3HZJxM=
Authentication-Results: quicinc.com; dkim=none (message not signed)
 header.d=none;quicinc.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5715.namprd10.prod.outlook.com
 (2603:10b6:303:19c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Thu, 6 Jan
 2022 07:18:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 07:18:22 +0000
Date:   Thu, 6 Jan 2022 10:18:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ath11k: add configure country code for QCA6390
 and WCN6855
Message-ID: <20220106071812.GA3897@kili>
References: <20211201071745.17746-1-quic_wgong@quicinc.com>
 <20211201071745.17746-3-quic_wgong@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201071745.17746-3-quic_wgong@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0064.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615eaab1-dafc-43ee-3755-08d9d0e4b8bc
X-MS-TrafficTypeDiagnostic: MW5PR10MB5715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW5PR10MB5715D45DF3EFC5CA21BBCC998E4C9@MW5PR10MB5715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3P9Qe3tpSPEglf2VPlZB0GvS8kzmNvs1dZgiJcUP8wmlftAFFFWCL4lfC2um/b45tZaKseBQpMVNahvR7uKvJqJBTfjLuEDRG2qXrHlAJs4UHMtjePYvLMbsY+XI762TjBdLyN0MEwCcAken/dHTSS3QB6S+fuVfPBUp/L4FR+eMCzT8gZoHgwgaVNI9tiRIrv5u4pEsVmb07yI9Vz86OzhFOMKVPwCgFGBhoXGlib8WTwX2wPI2hmDJVnSno5onMmZlCAn1aStnOcyv9vrV6Z3VBZJDh5atnV2B8zLFdnHZe1lQOd2INIGJSwQglLawS12l7eNOBcJt0/u2JOF1GBucK60Wh8PJfwC0bbJ4N0gQDEY++vksuuZoxar7OBOXrrYEYy+v5+ztCzIfV2X1wkIsYEUWTG/m2STeuxzXi+JPaB2bEgJOhbavocHFqqkzeKWtHymsomQo6aTh0CAoba9b0hTye0qMZjCQaVeAuJgEv6ZA5g4DwmEPMdWc3IEMupQpEcTsU2rZ5oNc4GtzBk+l7xZSr5pz98lw3DxLIS2AWOc5Q1UOKGPyxvAYalnc9m1gpBpWVAJE9KofPuKipjf9XkbFIKlG++WyhwdkPoQwaIrEuKzqnYaGg20AlPXLfwpZ8bCxUEy3QwqFAwqUnIIe57jr+OSE83GVHsZgKZzKjiz4gmzDPDaa9ZQ9Tv5oT7nZOM4OQdcOTrHuUxivXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(5660300002)(6916009)(52116002)(316002)(508600001)(6512007)(6486002)(44832011)(86362001)(6666004)(83380400001)(38350700002)(9686003)(1076003)(33656002)(66556008)(186003)(66946007)(66476007)(33716001)(2906002)(6506007)(8936002)(4326008)(26005)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T/GZG0qotn1t4zlKr2nMdOZ3ZE6M9DBDp01gRoSDkma8h04sz0HyoRtoehRR?=
 =?us-ascii?Q?eHZLXicE7EWSv9F1T9gZmNZIU23UMYQE+8A4c1R/NMsWBTkjcS9sS3H7GF5M?=
 =?us-ascii?Q?LoodmnyOGB+70B40jjRvCk9Y2OVY/Legc6Mh/9+4+V4BWOMUjwJfg/xB1KUP?=
 =?us-ascii?Q?gCaczjLBtS0iE9ubhEx5vdF9XkFVEC2NjGa7hH9ZSMeXfcViy4v/GwwkhTVz?=
 =?us-ascii?Q?aVcyPZ1R5qMHpX8raOwUdFxrLs4i8Dvf9qBjhaUVBo3xQ9OvX+izkjLARX2l?=
 =?us-ascii?Q?Dmjqb6inxBl31+Lk08Vl2JOQKQ47W2tjLKIASDBIU7fQtkeVOuk8L5bxJXms?=
 =?us-ascii?Q?iZ8LKOvKGMBm924ytZWg14UyXFf4fEj/ONbhVf433yzq3vN/Ww7gy3Z8mP1x?=
 =?us-ascii?Q?dwU538IGUPOx/sRuakTlfieVdQ7uPp0RDmxsyNeI2t4Qhqa3sSMucYes32Mk?=
 =?us-ascii?Q?7HtzywmA3eNGet4bR8Z2UFMHwb08BWSvL3VFw7v98q5qHN5FTOKd/4LsRG0l?=
 =?us-ascii?Q?avvDzVjcAEfkaIm4jtxXWcirIea/84lPIkkCQTYeOHzla5dsJ3YCx2C7HpSy?=
 =?us-ascii?Q?dZGx6MJFW/SJ1WAvm7PK6g3//WqGzSvEhvUCjVKzPfyW7Hy/x5yjo3i0IC/9?=
 =?us-ascii?Q?dg+jNAg0h1LCVu2HPGuHEhUSgsohUyLZhd93oO3xsTyD4oGgrcOAKZQSzFYF?=
 =?us-ascii?Q?WLcvkCAtZi1GhSvE02ivGo1wI35pRLQ/ub2lWy+YuttzlA0Av59ndRY/y7GM?=
 =?us-ascii?Q?AntXKo9wGfZ3IvPjiOWxsO/RmGufsTv8WqRkD1QS42gSJE32tXheCaE9BW+y?=
 =?us-ascii?Q?CgJ1l1U+WA62sQTtF1bEW9za+RziiSL6DLNyadgYIL5HK4gOiCVcZ1AeYD7N?=
 =?us-ascii?Q?pueq3N5ZwIpdxd48QeREKkkc8EWZgHJ+j5szyRkIgCUYZe93VM+SpWuLw8ta?=
 =?us-ascii?Q?9SMpQg1/zBl0gcGDvl+r02EB2Iu28tGhAUde982FBKi+i/HPdGdjxxWcZ7pX?=
 =?us-ascii?Q?swcSsglujZxaeEahvWNUhpNyV+eCrljfxxgwZr2mdUOcI6ff1801MZLcT7mL?=
 =?us-ascii?Q?0nf/uvtJy3ms9tWCVGUS38IcWNeeoeCyJiA0bTsOmr5x38XhHeXnTQla3q8j?=
 =?us-ascii?Q?7HCSZvHrBO/dFV92+l7yO0jGQ79Egvn0d7eseXvtOBBXH86bONP6q0op1Yqu?=
 =?us-ascii?Q?3yvbWe6ToUya5XOUlZbRMfGky/7WMajO9tjFy/vlxX8VGCifKlay5fctlkNL?=
 =?us-ascii?Q?vnv6uz8O5GqhCMXDE3hEJp8oyFI6zX5Mt9WdFB1h6LHP/uhAw4KSsrz5W3+R?=
 =?us-ascii?Q?+uJTNA4dC5dGiUhw3TyT9LS8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615eaab1-dafc-43ee-3755-08d9d0e4b8bc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 07:18:22.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RG8pLY7AdB+fomoryA388XDAAHyepyTDw/RlH0FU51cKGcvs5jhBcW8bYNfMlih6yFz2HI+plxRvtcUgabLZiCb3WRrDOIi5+9z9Mwgt5EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5715
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=970 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060049
X-Proofpoint-ORIG-GUID: rddCiD9xf7wpLyjVOkyPs1GpvHXa4iVA
X-Proofpoint-GUID: rddCiD9xf7wpLyjVOkyPs1GpvHXa4iVA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 01, 2021 at 02:17:44AM -0500, Wen Gong wrote:
> +int ath11k_wmi_send_set_current_country_cmd(struct ath11k *ar,
> +					    struct wmi_set_current_country_params *param)
> +{
> +	struct ath11k_pdev_wmi *wmi = ar->wmi;
> +	struct wmi_set_current_country_cmd *cmd;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	cmd = (struct wmi_set_current_country_cmd *)skb->data;
> +	cmd->tlv_header =
> +		FIELD_PREP(WMI_TLV_TAG, WMI_TAG_SET_CURRENT_COUNTRY_CMD) |
> +		FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
> +
> +	cmd->pdev_id = ar->pdev->pdev_id;
> +	memcpy(&cmd->new_alpha2, &param->alpha2, 3);

cmd->new_alpha2 is a u32 in this driver.  (In a different driver it is a
3 byte array).  So this will leave the last byte as random garbage.

Probably harmless but it leads to a Smatch static checker warning.

drivers/net/wireless/ath/ath11k/wmi.c:2837 ath11k_wmi_send_set_current_country_cmd()
warn: not copying enough bytes for '&cmd->new_alpha2' (4 vs 3 bytes)

> +	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_SET_CURRENT_COUNTRY_CMDID);
> +
> +	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
> +		   "set current country pdev id %d alpha2 %c%c\n",
> +		   ar->pdev->pdev_id,
> +		   param->alpha2[0],
> +		   param->alpha2[1]);
> +
> +	if (ret) {
> +		ath11k_warn(ar->ab,
> +			    "failed to send WMI_SET_CURRENT_COUNTRY_CMDID: %d\n", ret);
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
> +}

regards,
dan carpenter
