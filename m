Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56916462D8A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 08:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbhK3HgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 02:36:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39992 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232892AbhK3HgT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 02:36:19 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU7Rhho026596;
        Tue, 30 Nov 2021 07:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=/Cb2FTBsejHHxOqnfeuOOTDEv+LY9eQAyH28TnnVYWs=;
 b=isrHmeVc2HucBZV6E9qfMdc1B4iCGLFSJIWtci/ssd47vLg6BL5xEsBg0seHfR9Lgnxr
 EU+vLw5UbhJhCZrso2AYH5u60H8h3Xddm8TMJk9pDIrVWc2G0wg/j5VGdlccqkmZhlct
 N9VdBRpw9EV7MjXX1AfxO5ZKKr/+aVqDD5MW7DR52lN9WcV8IPhW88LialSMZ6nC/JzL
 9mizziHXS6BzcD0bONFm/SbopVkCCYA7chEA4jFW5MDGTNTjeTCMtYRzQfHEs4H0T4c2
 xzInqRufLLSIpVJV/Gj3ChKY/riFog6YHKMwNQgiGfOf/AcV57iiw+mx6Bymi1K/EDWb ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8c71g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 07:32:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU7VbIG007509;
        Tue, 30 Nov 2021 07:32:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3030.oracle.com with ESMTP id 3ckaqe6xu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 07:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feX7BNF9rB8HINjSusKs98cyFYNJ51up5fMmHwso8MbI4xWpNCwjiKus9msLA6S86xnZi6g4QfSnnnMhGKzv+KoXZS6hi2JEQA1+UoR90f6bNLTDQ22hg19dY2zTmuWTH97jiANe8b4XvJkO8kUUnbGItimgwTigoijJ4Eve5UVGJhdCNVcSgM5nCEQxrrkF7Lj1vYRTdzdY2DdIcJ30x/4KI7cbt3/E61/XE5sLL8Q3oABtcH9OUOSUIa/XWrZ4o4zjAWMGesQkxmahLrC8+j7xWoiHnyGkC7H5P1eteZvVZTxd8CmP9J8bV/LZJ0Z89w3TJ+g+9woXEYh6ABULOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cb2FTBsejHHxOqnfeuOOTDEv+LY9eQAyH28TnnVYWs=;
 b=H1mBZxBeGF84g993RvEpvV19Fpz+21iV2r8TbKiJ0kVX1KvwKpizKBdayCCvuHAmrc5ltyqVExW4Vu19vWGj6voSKxTSejJ7XLxW001k970K88WyjM1pDOdFIavrQUwYhd2z2yeD1n4bytphYNUwv9Dr8ED9U/r7cdVBddK3YlwKmPHveEXyhdd0f3JwWWcsggTZqHMFyRd/BYxQZ0R79Yb9SpuozNrqBEZDL5klinMxPdMlEriPB0gWj50a9WpdZuD2mk8jf51BlzYZTuVQw/W1zs0a+vkP1qw/zeZUepz/mB4xybTYGJddTVn2+TG77gBcH++BFZD0H6aI1IY8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cb2FTBsejHHxOqnfeuOOTDEv+LY9eQAyH28TnnVYWs=;
 b=dNYqFrzxb/wT97hWFLLKvuy/09cXDMk/FHYOnPzgh/ssU6rPHuEq+jikU0Xl1LwTzlWoZ/UxW7UzSyDJbPuPsz4IClDErmfiyFX55LKdFdElqJTA35wpjBgnGU/UY6d3U7Q2ibUBghGuL20+dt7D9O2Y6ke7ZPU6ZvHlG+0jvWE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1424.namprd10.prod.outlook.com
 (2603:10b6:300:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 07:32:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 07:32:39 +0000
Date:   Tue, 30 Nov 2021 10:32:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     emmanuel.grumbach@intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: integrate with iwlmei
Message-ID: <20211130073226.GA21360@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0003.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 07:32:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1857521-f653-4f4d-9fd6-08d9b3d39691
X-MS-TrafficTypeDiagnostic: MWHPR10MB1424:
X-Microsoft-Antispam-PRVS: <MWHPR10MB14248076ECA814A2EFA997938E679@MWHPR10MB1424.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stqGH3xazpoBVzcswugQz9+tkR2CSTlUnv2PjVf8uMIeZ+g3x+HKj7F4O1+LZrXWHV5MUeWgeuvewHyeBTAJpEqxyhSCRsVNcUUzSdIgyvoa/BefcsnMawFT31LFh5+Z0zQ11sjsunxQvUPt/URqHf4bcBL1JZfDrrLbpVzJ5ueVUr3/M8wmtcVTKyiVPZWdDfk/XBz1lKqhnbU/vq1nwcvMHoAnxTbpFse9/Tl4bT4ydo8ePbzXBz/UNTJtpmXGwmrEZWoGQL11FMiR4jZhXVPSPa+1NU/uulSb6VhcX2fa2si10JAf+og/WVRASCgOEhFmX53lz7bgXKTPorvFN+yd5/ZclhXM3GVV9g/d32v2zVhmBAEDy1A6JUaXGcpSnFtJLXWC1ouqQ0hpzOX3tbEbxwX2pQ5YFphqhijqZxnUssmz9RzwTtpx3i+LNjIAUX6b4IMo6xLEijPox27LpkP8pdjZ9BaXyDRuYhXn3mAx1gUUc6HMtxE/hyKqQtVM2i4xikJVFzuTIhzbi24tuqEAus9C4zlxdUd4Xz+KZAT+E3sImJ0+739EN4b1g5oJmC6/T/gqmKO5TlYu6g6b2yqWBs4KobPeoq2nkpWqtwRQuYswv9PNr/ZlkMXi7k6EtBM204IkdCybGyuhg3x6pz9nn1HDv4+9Cfp3a6nCPw98VR/iJPYlN+CvyDE+vwKtV65qtaScp5I7arjN/JmGsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(8676002)(186003)(83380400001)(55016003)(86362001)(6666004)(44832011)(1076003)(33656002)(956004)(2906002)(6496006)(66476007)(9576002)(508600001)(26005)(4326008)(33716001)(316002)(66946007)(52116002)(38350700002)(5660300002)(8936002)(66556008)(38100700002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q61VWBL/rX9yLw1OCH7B8eZpOi/iMvklI5Rbj9uxCGzffKE7m7WJ1jb+wJpt?=
 =?us-ascii?Q?l4M3g/DWWZOoH3EnJExFsaIHpQ+hiN9L/UIY/TUo/J31eEFoU828USpgCKSE?=
 =?us-ascii?Q?ioWpQqkbdaRBsZzgIJworzby1PFGcLlk9q2G7A2JI0V3y9NQI+LyDuMaKtSj?=
 =?us-ascii?Q?9EYpg0IKKciT9HM1Ya22hoITDn/NCIrgCUS99tVsLdMRCMs/EiDZXmY1DIxq?=
 =?us-ascii?Q?rzt1kBM7RFtAJW9oBE333ulx2j4s518uDFauEVb939zAdiH/g90S5NV3+OGc?=
 =?us-ascii?Q?ac0dV+LjwQIjvBXXU8FIz3HHSrNwwt8Vle/qt+vN2pmQvUwUeAQWMK/0VjbC?=
 =?us-ascii?Q?EDKNxcTjBxAWKKwg8pjXarTrx2eLXXHd6mCpnudldKCs70br1nXP/B1Jnful?=
 =?us-ascii?Q?51V08orrVBnOLfhq2Q4ZlaCDidmrdJQpxN63M3IZCxKFZisiec/NTPi4afQE?=
 =?us-ascii?Q?4728YST7IGFCVywKAD6smPrkSlKMfnzpQfg0E+yAaPdIvSPDtQ5kkpP71ulf?=
 =?us-ascii?Q?n/EZW33WLurO9p9iTyrvXhzgDNVq8Sbxb1SReyRtxL0C4M04pMXuN32oZYn9?=
 =?us-ascii?Q?wz2wMZB/jPvlI8vPgnbeFgOVyg7WhDerlpjib+KDnFdPM0E/KS28qKAjap+a?=
 =?us-ascii?Q?84LZHbkCIbaImP5p8dMV+sBHcEhtqNy9pAF9xBdNStWM7PShIdK2fBAVU4r9?=
 =?us-ascii?Q?XfzKS2+9OIbiTsIh/lApHoTBFfld3ZDLa4Wvg+HAbl9l82pG9HVb/qwi7Ci6?=
 =?us-ascii?Q?ruYBdw1DmsNKpkWl63qhhBbUC+iXw5EAHoWTeoT8OE+/WT+6aDpokkJry+qg?=
 =?us-ascii?Q?2Zuvqi0faEa2mGanCFmsfG4NkVAermhjNKRGG25HgmSFrNfy5xahkufYdLxy?=
 =?us-ascii?Q?Bly04ECy72UWR8tHWt9s/4m2rYnLV6hYUB4Qx06LlRmzTqjaDJ3txunU6KIT?=
 =?us-ascii?Q?bYoUJmTP3c2+wvgca/1UdRE9KJZHR1EbuXMDAJxY7Sy93qFZ1IsVr1UJC0XG?=
 =?us-ascii?Q?xN4p0CDLwObKb0bs4cJx5dxc8RB2DHpnXd1xfL7HqFqqyXpCvC1HUSEUwuX9?=
 =?us-ascii?Q?VR+e9KBfrZh4tgxoOpDXC3lJ0CzCTTtvh4pf+R+sh+UbfOi3SMOrEn+vklGh?=
 =?us-ascii?Q?181YPMPQZJtm25I3Cyh+WoLEKaEFj9EeCL8LfVplSApzi7fzco8Do7kn61zK?=
 =?us-ascii?Q?EPRbLJHtnLKo7PJGFdUFybvNB88RWa0EHTIkgV1q1Nza2YlL8kfxUa9wwfQz?=
 =?us-ascii?Q?WAXqTf0Tgdrcgj5IdUwni6YVZR8YMYO9flKc++eaWh0UQuf14ND7bLLAG9lO?=
 =?us-ascii?Q?RlKNLmdL3yfPLYDwKobRJti5lgvffOkF1nm2Cc2VQYuRr66YTDf5GG8daMNQ?=
 =?us-ascii?Q?Bo6Iekx1YBkOUZgjouGbhuGDDQJ3p3KxpVzhAeH5QOc9LizOJh0G4L+Kfm92?=
 =?us-ascii?Q?5Mxz0FDtNqeHlXe1OfUbfM66+rzlP0oKRwKcYoFVLK3lu8001HvL1xyGhq3K?=
 =?us-ascii?Q?Qq5TGaB4DUGjhzt+BjFOPTlkcsSeF2Uz4VKEdiuMeIsddBaWq8YsujHvmttD?=
 =?us-ascii?Q?57Pmug8Mns5GHZvbnrRl1R83vWHGFiT4acgxll+7QX6x/b0JwAeLJvEpDWqq?=
 =?us-ascii?Q?v4vpxrID0tbSMCNmOBCaYHnXUMbdXJTwjvdfJLt/4U+vhsRsDIv8lNOvjiLx?=
 =?us-ascii?Q?/M6zPny4Dj+HkbTepBoGPHwtDQA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1857521-f653-4f4d-9fd6-08d9b3d39691
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:32:39.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHCovJPtywXyvSaZV4Gju5IIhJpnfZjJq0TK5e7NKSVJXp/SJeYMHbi34AWQ59GCpqYX5+lDWPLJQscTHQIjQIVhkRzS/h/60rz9oARZh2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1424
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300042
X-Proofpoint-ORIG-GUID: VSruH0BNCe8QawmAI-1sWA58HiQDAPLC
X-Proofpoint-GUID: VSruH0BNCe8QawmAI-1sWA58HiQDAPLC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Emmanuel Grumbach,

The patch 6d19a5eba5cd: "iwlwifi: integrate with iwlmei" from Nov 12,
2021, leads to the following Smatch static checker warning:

	drivers/net/wireless/intel/iwlwifi/mvm/ops.c:740 iwl_mvm_start_get_nvm()
	warn: inconsistent returns '&mvm->hw->wiphy->mtx'.

drivers/net/wireless/intel/iwlwifi/mvm/ops.c
    684 static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
    685 {
    686         struct iwl_trans *trans = mvm->trans;
    687         int ret;
    688 
    689         if (trans->csme_own) {
    690                 if (WARN(!mvm->mei_registered,
    691                          "csme is owner, but we aren't registered to iwlmei\n"))
    692                         goto get_nvm_from_fw;
    693 
    694                 mvm->mei_nvm_data = iwl_mei_get_nvm();
    695                 if (mvm->mei_nvm_data) {
    696                         /*
    697                          * mvm->mei_nvm_data is set and because of that,
    698                          * we'll load the NVM from the FW when we'll get
    699                          * ownership.
    700                          */
    701                         mvm->nvm_data =
    702                                 iwl_parse_mei_nvm_data(trans, trans->cfg,
    703                                                        mvm->mei_nvm_data, mvm->fw);
    704                         return 0;
    705                 }
    706 
    707                 IWL_ERR(mvm,
    708                         "Got a NULL NVM from CSME, trying to get it from the device\n");
    709         }
    710 
    711 get_nvm_from_fw:
    712         rtnl_lock();
    713         wiphy_lock(mvm->hw->wiphy);
    714         mutex_lock(&mvm->mutex);

This code takes three lines.  I'm looking at linux-next next-20211129,
so it's a little bit different.  The original patch is buggy but it's
made worse by a merge issue.


    715 
    716         ret = iwl_trans_start_hw(mvm->trans);
    717         if (ret) {
    718                 mutex_unlock(&mvm->mutex);
    719                 return ret;

This only drops one lock before returning.  It should probably be a
goto unlock; and we add an unlock at the end of the function.  I would
send a patch for that but it gets a bit confusing because of the merge.
Emmanuel, could you take a look at this?

    720         }
    721 
    722         ret = iwl_run_init_mvm_ucode(mvm);
    723         if (ret && ret != -ERFKILL)
    724                 iwl_fw_dbg_error_collect(&mvm->fwrt, FW_DBG_TRIGGER_DRIVER);
    725         if (!ret && iwl_mvm_is_lar_supported(mvm)) {
    726                 mvm->hw->wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED;
    727                 ret = iwl_mvm_init_mcc(mvm);
    728         }
    729 
    730         if (!iwlmvm_mod_params.init_dbg || !ret)
    731                 iwl_mvm_stop_device(mvm);
    732 
    733         mutex_unlock(&mvm->mutex);
    734         wiphy_unlock(mvm->hw->wiphy);
    735         rtnl_unlock();
    736 
    737         if (ret)
    738                 IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", ret);
    739 
--> 740         return ret;
    741 }

regards,
dan carpenter
