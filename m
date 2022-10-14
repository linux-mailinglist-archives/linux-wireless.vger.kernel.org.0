Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF7C5FEBCD
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 11:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJNJiK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 05:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJNJiI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 05:38:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CB1C1165
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 02:38:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E9KSLR020215;
        Fri, 14 Oct 2022 09:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=+xw6Utw0YL9j8y8w/iXAqnc+2feU30jpg07liC3Z0hg=;
 b=jF2n8XM6diQ9CdoiFLLRkrbqwe47mVLyuFZYdtsFM7/WbVui7qA8EqI8rzm5X28x8Gky
 jlFEoPuKd7Ue9A4GNChJKknsUo6SJTLAHVGINeE/Kp6u7DardLdZyD343V6cWhJIOU7o
 X7jkFLD2RaJKKa8TYDEkslDoyI/csncSYh/3VoxI+e9q6Tb+6qiLEoW6kEozz4x8xlrh
 fLJa9mYVobG3RooT1qHYCUOabxR/FXdcIPFqyTjHVjfenDtEzLP1YTEZx3O41sXeOiS3
 E4RTUQ3iFw6L7PBSQUHNBl1XBJk4e+iwhoLeEk8X4GaJRg2oONWEchpI3uOvhGdu9T37 yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6kgmtjcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 09:38:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E7AEpj009827;
        Fri, 14 Oct 2022 09:38:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yndn7yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 09:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHa4JmJI2OCAShR9TV+cJ97xYXDilu2Tss4xAsbC/Tm8auqEzPj6Wb+6QdAoSxjDZtoLNsW20GyOI0voVQ6Pxc+MuLvK+ZuJyOQhdXNYm6qOA38nURrAw18F1MZ+EpKGOF0Bk3eVFxHfVX28jUXI5XS9AD9FhvWSWZupAJfJo+9OBsgF8p0GdOF4h9z+grQfCH4Ic3ZdjOSSpPaMVzDJdgFsq3wSbrHxmxr4XezFJeFLp/tH2Wdw9VljJzzVuEZuwDLs79QSIvzM6OgJQ5uCt9q/Q3B0+0h6slFLjaKa5ficKNKtoSgdaVU87ZRjFQwxRQ+qhwxqk7vyFSxlQR+w3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xw6Utw0YL9j8y8w/iXAqnc+2feU30jpg07liC3Z0hg=;
 b=Pp82hrVam8m5IsuPFX0+TCgngAj4XooVNURL1X7+PnOyXhDGFv4ksZ1STNAt+fMyQJeYVCmgqD7NKc4kL7sCsTvUTgdbfRPhdQO8Pm2NMwB38gbEJ5qHiv8hySEMxjEyuoS/pqGigpKlVGU8i8y3S94UzlLWSuAghNYEuyyRvKgZdqnM3wtkGrn8F3ChvkmQsyYGZ9d2oUNBnBWrDTO3ZmQdEAPuosv5ts+AimnYxmnN8L1HzPUxyFjMibdFhB5YI/6aMsreddSyzz7BDrw4vSLnqFFIWc2q8hCb8N4edg9ylJnlsiAYfChdwTTmb7BEStoqwrOgiAo6WIyMWyKPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xw6Utw0YL9j8y8w/iXAqnc+2feU30jpg07liC3Z0hg=;
 b=CgDArrqENQB4hyR9FIu7+MdIUdWeqGPfDiuDu2eOT4RE8mVu799RyB18XIHkoQq1AZ2/R1Lk9/VRQ7p7tVOIIP3zDv9nf8y7XWR3Zh+L5WCtGxKA78GOMIfFISf8qLgN89O4cZmtB8AvciSoM9f8sTg1pIWwdHH1/kg4fJ80Eb8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 09:38:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Fri, 14 Oct 2022
 09:38:02 +0000
Date:   Fri, 14 Oct 2022 12:37:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     haim.dreyfuss@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: mvm: trigger resume flow before wait for
 notifications
Message-ID: <Y0kt9GZ92v6Jjtsm@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CO1PR10MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: b38487b3-56e2-4ef6-d0ad-08daadc7ca17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIxFaKdlYqFAmFwIqVcgMm1XVsQA2kKaje0n3aGoAH9Amo0px2MU3CmHSxqc5fSgqtK4A+hfCaCdkCO0Rikx5pSEsJYwXyJBNLmhpRIIcqN9nlLmLvuseQKPx2gGJfXH2Jnffq+KlR65gQaQJjUTYfhZVcSh7tlEememWeqT1Lgyg+IzjxPAdworrfb1AbmBHeu/9NGvGhNHZcEpS8Il7Qncr/ZXCBpfcxzuJbGM+YRXauOWaI7yvPwy3xc9pV8TqoWGSBcgDk45173cdLH4LXY1oYfMGe8ghRoslK1ub5nt5ch4MnbFJAySo4zv6fF4AiEADSbkjukzeW0j7jfh9Aw9JJLEWSQG/PQOo+R78WqHvQJ+us3b7Ew5hfXKewr/3ONL2dMWG8673nTos26WL0uM7ozrHia9Tlw9I4fwDS3vDxLIuErYu9vpFveBpw1Y8VTuHqAGP0wD4IuiQy/GWGtuloqsPVxAxEbbWEI5SiIg+ZZ4q22so4s3xyCusSmji8D47G1VXiDIMWZhlYwovwcJkJI4N0KCMsSn/qYe/7CM22mXCqGJ8TevgNwaGIwdM3ocMaSCF6EJHc7emmmj3gG8t2tL8lb+c/g/w5jPy8f/u0iXAtHwDkvKTR72IkDeWGhLZZrhPiM6DDB+znKbkYlEoH4ZJeEVvx5URaSvQkrkFZefVUs1XHQkkpgW0Ye4h97GK+fKJVSa6j5axFF67w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(86362001)(2906002)(38100700002)(5660300002)(186003)(9686003)(478600001)(66476007)(66946007)(33716001)(66556008)(316002)(26005)(6666004)(8676002)(8936002)(44832011)(6916009)(6512007)(15650500001)(41300700001)(4326008)(6486002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9Ot78FlbQjXReDWQ2xd6m3k0XF3hEkAXIFRg5Vx+fJldoqnhCqwc/8jmazg?=
 =?us-ascii?Q?T8vfAjRTgyxPgipeTSZMw3H6mNf0muUr/ZxGZCHlukmm/FChFLLzheyoC641?=
 =?us-ascii?Q?S0Xngjx6hyBu5JYDlvul/c8A8wQLbXkjIAI83YO0IDtstqVXN64eQswphYp0?=
 =?us-ascii?Q?vdfBJgNpR0DYnzCLJFHIvRSPzLtESfQM96OVtcoguQZyJTNSciFMVP/hjgtZ?=
 =?us-ascii?Q?YTTmG/+ypAGYmumupMkxw0QxO3rx7JpxgYn50pcdar3bTK2+/1v1GLnmtN6G?=
 =?us-ascii?Q?mYcdVMCMNXicgMGgMhg8vmcDmUZVXpn8QKkE1yiey91OtgZpYsoYGMKmjYAP?=
 =?us-ascii?Q?lRLYFKR3DWaoIq64Z2B6g5u+ifNT7bxQhzO1iq43Tz7gNpt9dyq+PXlmQ3Rq?=
 =?us-ascii?Q?XANpwUlBUIO76DFkUpmWXUFGD6gav34TyUr9JQjchveMHOdlbcviJdO5oNf7?=
 =?us-ascii?Q?B9+CZEg+zWsod9G5B8jCq/KqOtjp7DQ4ZA/HuVc4sy1oGpsdCYlB+R0Cik0I?=
 =?us-ascii?Q?Foxy0hHoLtyMfcS9wIZAxNWP/C7I00GzIqMFCNaMarr2z3EMdiavXmtpzcCt?=
 =?us-ascii?Q?lS8lSPbcs65ESOLDiiX+913euFsYsoHz5jaF+iPpTs1/skOrdhONJkWuhuPz?=
 =?us-ascii?Q?6br0VvFP6WpC8xczJjlTjOjGFUHC+AtV9O+mcHCHe5yzoQDX97FTIOhg0pFs?=
 =?us-ascii?Q?oXZQF/+XMVFh159sqgABOLBFLm4tKhGLGFRrDWCuXS3bXaG7HqxU7QM6/R8a?=
 =?us-ascii?Q?W6GvUWWKX6lD/xCQCv+ETh4bm3XQ5mLkEoNgTQXixJfohRYmWpXwii1MSxok?=
 =?us-ascii?Q?lm2HS/J0fwgGxc+kOv+WmgF2WtOz3iU9w/0C7iU1DTWHfncaDv8FQpjbFmQm?=
 =?us-ascii?Q?ZMJkmL1RD5tmkrpNoWq/WSSaozPCwdQfbl77KQ80jAqZFyRq4xR0tSBnlDVH?=
 =?us-ascii?Q?KVAd6LaE7X1h7oe6sQhLdC0hixPo5LYGTbmv5Fs3nk7E+zxntJ0HEPKqUuqP?=
 =?us-ascii?Q?rY5ZnUu5J3n/B6N6s/f7/P7g8+gviCrwH2W1ZB7EjdF8hiHryryFGEnyzH/k?=
 =?us-ascii?Q?rCMjOEFtnHKAv7FYbY4oHEn51DdKBIzexOmTfcC4ecHP0A/sGVSe/C1IuVzU?=
 =?us-ascii?Q?AX27lD4ZNbAPErdLZA5S1bkpZNd1HZ5MguZXUoJGUpQffL8BWa71NFJPCXLO?=
 =?us-ascii?Q?W4kW98dtseD4Pj3Hn2Aj9L27HmFToSPJORtlKcXy3lpQDJLDzDLpyZubVqNZ?=
 =?us-ascii?Q?NDYGvJ0JDVteJFW64rA0wonRA5XUUW+yvXq+TeOVAs2Fmi0YHwxdKZDg/8Ho?=
 =?us-ascii?Q?Z92h8lb7kVv5H91p11OS1pAl90qVl6Kn0/IrBFop1TwgDQGg+KKSMFWCy4I+?=
 =?us-ascii?Q?QP29zaOxu8FZp9qOIq/lPyueJIIUNcRLjLkLnUb0OcF4hJh5OxWKd8o4h8hB?=
 =?us-ascii?Q?VmvMNRD+S01xLYq0Q3QasxIVQ526NQzdWCxX8tak3OL1CXoRZTaQkyac7f+f?=
 =?us-ascii?Q?6kj3Wxub/sKTWA0ebogyQfMudyOoz05LZrokuZBNlWztaiZh3S5B3pMZB1PZ?=
 =?us-ascii?Q?rIggHUpUK+pYsy3TDFHwMj3Al/QrZkZKxe60/AlmRRmwJowps//Sf8c4dnVl?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38487b3-56e2-4ef6-d0ad-08daadc7ca17
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 09:38:02.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMKelyHb9vVmkLMnBc/1LyQ/TjP87pnPuO4RlsMbBWXofgHRJ4zFJimPQB8mYRoLMxlCosfKuddZmFJTLsFo/tkmZFWYfRorw2MF1ZwFK0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140054
X-Proofpoint-ORIG-GUID: Jcfhcg7mn8xNVD4zKwshWQN1Fw0Z-hDn
X-Proofpoint-GUID: Jcfhcg7mn8xNVD4zKwshWQN1Fw0Z-hDn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Haim, Dreyfuss,

The patch b75dac847c94: "wifi: iwlwifi: mvm: trigger resume flow
before wait for notifications" from Sep 6, 2022, leads to the
following Smatch static checker warning:

	drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2791 iwl_mvm_resume_firmware()
	error: uninitialized symbol 'd3_status'.

drivers/net/wireless/intel/iwlwifi/mvm/d3.c
    2776 static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm, bool test)
    2777 {
    2778         int ret;
    2779         enum iwl_d3_status d3_status;
    2780         struct iwl_host_cmd cmd = {
    2781                         .id = D0I3_END_CMD,
    2782                         .flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
    2783                 };
    2784         bool reset = fw_has_capa(&mvm->fw->ucode_capa,
    2785                                  IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
    2786 
    2787         ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test, !reset);

Drivers are not required to impliment a ->d3_resume op and if they don't
then d3_status is not initialized.

    2788         if (ret)
    2789                 return ret;
    2790 
--> 2791         if (d3_status != IWL_D3_STATUS_ALIVE) {
                     ^^^^^^^^^
Uninitialized

    2792                 IWL_INFO(mvm, "Device was reset during suspend\n");
    2793                 return -ENOENT;
    2794         }
    2795 
    2796         /*
    2797          * We should trigger resume flow using command only for 22000 family
    2798          * AX210 and above don't need the command since they have
    2799          * the doorbell interrupt.
    2800          */
    2801         if (mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_22000 &&
    2802             fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_D0I3_END_FIRST)) {
    2803                 ret = iwl_mvm_send_cmd(mvm, &cmd);
    2804                 if (ret < 0)
    2805                         IWL_ERR(mvm, "Failed to send D0I3_END_CMD first (%d)\n",
    2806                                 ret);
    2807         }
    2808 
    2809         return ret;
    2810 }

regards,
dan carpenter
