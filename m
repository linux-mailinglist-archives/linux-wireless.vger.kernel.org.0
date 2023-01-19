Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD22674639
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 23:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjASWgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 17:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjASWeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 17:34:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978993CE04
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 14:17:32 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JLluma023333;
        Thu, 19 Jan 2023 22:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=tME/5Wz9KzExP+X8WdxHXtspAslMDMySw5jw2HspMuI=;
 b=MR4ziZGmpzsGTJb/hdbTUkkRtkf0JfvBJiFS28vv2WB+j3i3DtGsKfeAsWXh389HgUuQ
 YzaSIodptmwb1ZDGdhJjE00soHeoft6L6xVtvpM5GyWX5EkU54h9mRFwNGyh1iz5uX5L
 tZ/snBkLpDKf8ca0C8rlj9D6uKBs9ccDZxxtXCX6KATP/pHWn3cq+f5e5n+hufMMO3fc
 L/36CHzVwYJekgGREC1cyhmkVtvJab03yDyl6+zEph/WpFO9aKci/zLDoKlHh9MILtTA
 jXnYdXw6irfmUEraPmjJO3ZCK08bwpUasHK2cWUk3756cAtvsctyl+U65vlenQ/wd91V zQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6xktjgw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 22:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGwIaw1lN2F8j0dZX55BvbQhmgweysWCYazBhbRrmvWxLXvzkz+Iqt868igPoRSM2JPcrsSHSGqyiGFtfbDFaXyqpKIN2pU0eM/9MsBOlMuCF7o8hXcgBGwk/ZBwT/3ZCFh8k4Fe2MCPPnc+tB5S1q9lLgaFvW6ynaRTfaEw0qF1dO49mbxDefejLSqlbpcvjHdo+Ph8XyfiKlTZ369cJnG8KvZauqP4Mf2hahitJohoKl8oeiOyLEujU0ECV7moDYfA/gNnI/axPaCN3w836OiDTKD1pU6KCSnqGUsxJhIDLaMjG5e2F2DfWl5pjt7Cf6z9QC2fgB/cYyQIfDzTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tME/5Wz9KzExP+X8WdxHXtspAslMDMySw5jw2HspMuI=;
 b=hIagyUYGzCfk5nz2j97+tES39irLo6Fs5CoAvjNNs1Zk7rzdDDEB/c+mDxueMvsRpfCKOdXMKgHk35Cvl3DEx4q/36x3fXTp2FUixfqEUxi3B8p3odHA/+mSRRAiv1xOasOtFEnps3xTYeeeP5P5GuI1aplijbINZfYMwVwyuVoa/sD7lichKtXVAy6ABJzFOxR+tybuRRXQFQZJOBiUAOnTR6dTctcIgJUgu4tebrymFLkxwuelHHiDqgwqBw/9Kitnix40vMiIv+1yvyyUtHku3kGUg6be1zt7a2eeYFSDybrsHigrfVzVKQiBTgWhWc5/yINbObkOz9yXDHP4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by PH7PR02MB9050.namprd02.prod.outlook.com (2603:10b6:510:1f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 22:17:24 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::20e1:e816:c93c:67d8]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::20e1:e816:c93c:67d8%3]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 22:17:24 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: update rx nss for the link sta
Thread-Topic: [PATCH] mac80211: update rx nss for the link sta
Thread-Index: AQHZLA1N2E0Jpaz2BkGOCLwrpMku4q6l2QEAgAB2FYA=
Date:   Thu, 19 Jan 2023 22:17:24 +0000
Message-ID: <SN6PR02MB4334815B5844290ECD96F2F5F7C49@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <20230119135223.18224-1-quic_srirrama@quicinc.com>
 <e281918e9dfefb9f56a4f778be9dd4c8f9f9980b.camel@sipsolutions.net>
In-Reply-To: <e281918e9dfefb9f56a4f778be9dd4c8f9f9980b.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4334:EE_|PH7PR02MB9050:EE_
x-ms-office365-filtering-correlation-id: 49d8be51-f31e-4f17-dde8-08dafa6af0eb
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMkkKHchhQR6VmbxyWWbWXNK1yoq7pjWenVgWKxyLn4YVKb5M0XYAo2seTtu5u5raSWRWn2JEl1nC399juWHFxeHp6rB7BBrnNqczybwh2kffl7mzYj64l0FQECUROSAvU/CcNOq+q1HOyyq7fMX9sLF+ewWwymhZ8wg9SlKMkRJ5U4oEq8UzbLFtEIC2QyGMs0ToFZaRVkeIqw4WRNMMQ5iAa7OOuTxjBrtTCI7RrMiodFtSfffMPfTXYN9WxXGVT1VmohzZWWGBu9KpZQcSpNnINVlWSGlE7gs2ImSO5MR8iWU2OYkxc5ajy4SWD0xI5t465jsEnu9GRftMFko9n0OH1yRa7gJbbMHrf8YPGgIdRiveS04ozev+I0LXyhKeWa/7X9NglqtTWB82CHzym0/BvSrCbg6xzfrB30l+PAiBGO53lxwHway0K2oA+GyivAVEXVJ9rJz/uXKVc7KT595vYvpV3+R0Rj4kkPst9pg7SFuNnZzi4kCOcwNw1p9S3K6riFXTwG4CiTF/H9G9vkfKpo2JYuU4iOXNCjOKRTsIRFVGGIOAyZsp8lVR2gG0wTDou0kZjg0TMn78n7eIpPQBlvnEsV+iEPLJYfolBNILMIn51cTq2rJnDngTO4MU6Fn3h7cSmRxKI3Rbcol6UNGKZreX9/eGMEzRCRa33JfQ47lh13uDIbdod1ifnjiCfbNRfD9EZrLL8YfeH1bgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199015)(7696005)(71200400001)(76116006)(110136005)(2906002)(316002)(52536014)(66476007)(41300700001)(6506007)(83380400001)(66446008)(64756008)(4326008)(8676002)(8936002)(5660300002)(4744005)(15650500001)(66556008)(66946007)(122000001)(38100700002)(186003)(26005)(9686003)(86362001)(478600001)(33656002)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YCFdHT76q9KwnStYxWZ4BLBqNL43dqf2dvzLGsZgLegWdfZBV5RosFTyFMT+?=
 =?us-ascii?Q?uP9WnZS+CTjQoeysvslqFVanA3rT1K8QkyvY4KkoIQzlLrjo8j9d7f4nsmTZ?=
 =?us-ascii?Q?cDdEEZz2cBaejQ9oQWmzFtqefpmn+w6CWE9oIuQXkerIvYEwZx5jvCXXECIB?=
 =?us-ascii?Q?kJGle3peh+8rWJ8Unw5WAYM/FJVoZouJgMwOLsIE6zVrCiih67nwGNhQvGOY?=
 =?us-ascii?Q?9MWOfiivvVypnTA3fBGjwn11/4/nIlNCEL4icg9dI0SlIqP+oDSJo5OeBZyU?=
 =?us-ascii?Q?RFaxaM/zSYeZhvaIPvmPBWXWstuMq8INirWRtQ00sJTfQrSb6Eq7CDQJ8g4G?=
 =?us-ascii?Q?L7nIXCc3UO5K3SEt+J7nSOFBvNOFXKGUnVvaYO6MuM1uBblZST6541JWz5C0?=
 =?us-ascii?Q?wz7GoHGt46vy0IxpltmZ9IuTX5Y7qPjf9Ht/qPPemGArTfSGmFyS36mlQDG7?=
 =?us-ascii?Q?KTyHyxEnfW7h7zoLw2A4vqlrC64Fr1usxdiQLGieZ8+XTFg71Pvq1WpX39R2?=
 =?us-ascii?Q?Q7XUXNEN8eG6dtsGLjy+dIw7chzVmLbW9sQ5qkAsG0Yj+jiFdLxJpe0VlnBX?=
 =?us-ascii?Q?oTf5K7DdakshxipFSffJN0wONpXvxydhWIhMro0vNeEuo56+K5BnKKZd1bo8?=
 =?us-ascii?Q?doUlr0FnW22mQzYHEfz3BhZ6Qmrs5hubLphKwd6KbogxJpfod8pEYuhvQryN?=
 =?us-ascii?Q?+jkAOHt4ZW2UhSc1lpfciGE9s25cdkBKTt7JcppWvsi3wMlOcjJn40j30mXd?=
 =?us-ascii?Q?oH+M5ZZvBwJBEN+brZoGuzhWYliYPH2YQkGiI6nyWvUia+ZjECMGtKBModve?=
 =?us-ascii?Q?ajToPA0Rc86U3+iWcS7UqSZGT1uI8qliLdpzKevteFfhSEdy3LTFvutvKGY+?=
 =?us-ascii?Q?wlWQZRF+NShi+S7IWYep+blaBJDDa0Uno/qxLWxeM6n2YYH3KyCsQxvNFsRR?=
 =?us-ascii?Q?W6kZ3F3hRMhWkbx0eVLPmT7Bv/bt8VYAK0PDoyDZrzJTZQX4979hDWYrk16H?=
 =?us-ascii?Q?AtStT5jZUhsbT7RQIo2OUrWNE1s80D+sdfqGBXL6p/ugqOQX0DJzmaaSdDff?=
 =?us-ascii?Q?b1+gFM3ob5ooyrrifR82qRP2cZfsh+PenoY0L3QX5T2bAJ/ceTPMhSlRlFXz?=
 =?us-ascii?Q?0fuCobNS5z7y/Dv702QFFqNW1ZiG/pWASz9ubdMU7UebA9e2f2gwcD4bNnVw?=
 =?us-ascii?Q?/CzkD3FFmp8oOYn0ssLBz892Dhayuw9XhTCZLnZWuIYrRnwxA/LBISzZ7OES?=
 =?us-ascii?Q?TPtg3rbeVrIRYZqPvjL2JUbXCYiS5SG3T8RRDvy6MyZUmOiooxUPwAIYZBRM?=
 =?us-ascii?Q?oqsn5ytY/vldfjbHdCriqBIBz/ZbrL1rNywNSDNDjNzLoMzP0AZdP5QJ1j9b?=
 =?us-ascii?Q?VhxWig+4HS7ACHBWOaSjpQSk5KKb8bpUpdnXdeYq2fDCE8np+buo/pWQjhc7?=
 =?us-ascii?Q?L1/WG7AdUfs/ElwA4UuhybTU7BNmcNWBjPHis0+8jqgU8cB/Q8tNC9x7UyTw?=
 =?us-ascii?Q?TkfOELAm3pOpjOJdsbqhL6VtmIt378n1AKDJT26wlsV2vDuu0kfdvQczFWkg?=
 =?us-ascii?Q?8uxTPd3XWDHUkF019/FE8BuO5x/huTFG6LhzWu+6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XNA/k0BZ+UNrFXZTu2O1hKhV8tRH0bnivnxjzuOaCkE5Ur2WnvyE031GlLDXZlNt6Gsh718yB+JtTc+mt4Xvux2Y0adR1jbYmOithVwUHsmAeeYKJRac4QpRZQBlxxNz9fy4SU6uxrwVxFSrQgLK5wpa5yJoy1OVA1eVz2wX7lX/HuvDGaFrrFVi8ooTmM9z/uF7+5UGEPFyAZcZLt+RFVbfh1Y28JL77pbXBicZwZzkt2uDX3ow+VNy15SAs5zaKiiIGu2g+m9DrGyyPzKRzZ8WIDzBXQHbfpjrDsEBpSA92NPjTfsdRe9b6XtltYwcDZOzGNcim+ujy5GdnpaO/VBRftNrFxgOzkAonzWdI1JfWbQLIk8Abd4gi9tuFk025TXfsz/ed3hqoEtAec8ByxztR9nV+xLY7WRXavEBg77l+gUCS0ggwzZN83OwhPMKs1HpNOOy7znIrCVED+98Z655bV44lQuqZs+Oq/u8zEdsXMb2YamXPyy9DLnDME96r6hNuBcVLeI19jerEdH6Tc53yT7sFSSFLx5dZPaIkVmSzIib/0apkdnOsNsnjtz6XRkgyDR2V5ZuV6MsqbwzqZxem18HBaOUCGri2KwQnIUBJ10WZls9HdE4+8ln5At76NQezT+Qk7JTKyfLXt4unXHYoQx7JCnkNwUlKCqca3ly6swuqgIQlCQ9VI+rxzQ/ytvyyoQvOFz7sWfI0OKSUC9hM9er7DJ7GVnn6OFO1qx0mSCIHOEZK+NhCt3SYumeoyfH8BitW1EgcM+Y29hmv58kMNPLmLAUQOWmYiGBticH2Mo9+rue65af3hixAMDcf2N9XFH1R83OfAmptNPaCg==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d8be51-f31e-4f17-dde8-08dafa6af0eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 22:17:24.1501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcSXEBP6w1yAveUZpnJjmzT/OzvlvgsmN3m8tyLNZh2Q0p8BIStoivxaJO2fnHsWpqNx2jPuEoHNrjrLCYX4v2igfPEtY+KuM6eTabxO0e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9050
X-Proofpoint-ORIG-GUID: ajxvwpYMxpdIVD9FDf6QkFV0MmVt_GJW
X-Proofpoint-GUID: ajxvwpYMxpdIVD9FDf6QkFV0MmVt_GJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=9 impostorscore=0 adultscore=0
 clxscore=1015 spamscore=9 mlxlogscore=101 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=9 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>-----Original Message-----
>From: Johannes Berg <johannes@sipsolutions.net>
>Sent: Thursday, January 19, 2023 8:43 PM
>To: Sriram R (QUIC) <quic_srirrama@quicinc.com>
>Cc: linux-wireless@vger.kernel.org
>Subject: Re: [PATCH] mac80211: update rx nss for the link sta
>
>WARNING: This email originated from outside of Qualcomm. Please be wary
>of any links or attachments, and do not enable macros.
>
>Please use wifi: prefix in front of the mac80211: prefix. :)
Thanks, I updated in v2.
Sriram.R
