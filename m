Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CEA1B7153
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDXJ6I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 05:58:08 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:61036 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgDXJ6I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 05:58:08 -0400
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O9qAD5028094;
        Fri, 24 Apr 2020 03:58:06 -0600
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00183b01.pphosted.com with ESMTP id 30fvd71u37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 03:58:06 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9Pk5aemq2Us4nSj3KsgCZro+328DlGudJc9s+gTyWV8fxAbZe4lCVXgIJuMb8K10Tes95DHTNjXCnhS24EGrL/CCrjcHQHgjdF2c8Dwgenz31NRjgSEU/hXHKWhKT9cHYk9MTAmAqZNpq3BIdW2sVm8eoOqoJJGHEUT8YOu2oVE+c2wGGYwWTiuCF2my9lAlfMKeEjP0cQJ+bK1hWJrOJpxOr/sJcTMZGCZZqUqikaKWKN2EKX+WsgJ3/OF+R2j+dK+EP0uWcRSce5kAzndWwvbhW4DT4RblGtgNZkJHWmrhsi44tOrE/yLUvXKiCBRV+LwT7gVkFDVMiBAoPnwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrudurwPwG4JqTbOWdcpgoEqtxWUTcwmUELQxRfHR7c=;
 b=FsbRRTKYdDnzJoH6dZn74fE6d01oxN6DeHclSwXIVBX52g2c7tAAcuzy4XSyMdLcSEL6OJC8j4k/sikBJRugct1KyBIFBm/PDM2JAd7Fyyezn22R5r6+Us0ddjBaI8GLAsVvv8ZPlZ83l0QqVXIvmuMhYZKFbNjOPRKrz/17TWglSGuP8RSsqL8c2fr05mzevPBXprjwCUoU+W6fH2/SWYXDrKD0zPZ/qm1/U8I3T7xvZyndUqnVIkXg8A7jB68UzcyfyigWzFVm+4Uec43wY/s1f5/KZoQHwIvd97ksOUqQtdguDPYQV0H9nmto80QSNxlGkjyI5TJ2U0wW+wvl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrudurwPwG4JqTbOWdcpgoEqtxWUTcwmUELQxRfHR7c=;
 b=i6OYcyu1FOXW7i6HQ17iamVhsoSrp2R9TjQmZ3AA2TBJSVvT7bAfjuBs1F9QOT9p7520zwIJs5FU3SGeuYVWtofwUKATjbmqkmbb5lzSNytgm6Lh8LWeAZAm8+sGwAKpNRGsqy4jpxyFkHc0OQp6iDvBxGW2Lr8uTt4hsnvc1Gg=
Received: from SN2PR05MB2445.namprd05.prod.outlook.com (2603:10b6:804:6::19)
 by SN2PR05MB2767.namprd05.prod.outlook.com (2603:10b6:804:16::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 09:58:05 +0000
Received: from SN2PR05MB2445.namprd05.prod.outlook.com
 ([fe80::eda4:17cd:9f9:c823]) by SN2PR05MB2445.namprd05.prod.outlook.com
 ([fe80::eda4:17cd:9f9:c823%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 09:58:04 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3478.namprd05.prod.outlook.com (2603:10b6:910:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.10; Fri, 24 Apr
 2020 09:57:23 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 09:57:23 +0000
Date:   Fri, 24 Apr 2020 12:57:18 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     linux-wireless@vger.kernel.org,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [RFC PATCH] qtnfmac: enable access to the card in calibration
 mode
Message-ID: <20200424095717.a6aqndcvq4gvluwb@bars>
Mail-Followup-To: Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
References: <20200416210025.1096-1-sergey.matyukevich.os@quantenna.com>
 <87sggxj98k.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sggxj98k.fsf@tynnyri.adurom.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars (195.182.157.78) by FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 09:57:21 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5979c943-c2cb-4943-a0cd-08d7e835e268
X-MS-TrafficTypeDiagnostic: CY4PR05MB3478:|SN2PR05MB2767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB3478CC2E4FDDFC2F90C32EAEA3D00@CY4PR05MB3478.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 9:58:03 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR05MB2445.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(376002)(39850400004)(136003)(346002)(16526019)(81156014)(52116002)(186003)(316002)(956004)(1076003)(54906003)(66946007)(6916009)(66556008)(66476007)(6496006)(5660300002)(26005)(8676002)(55016002)(8936002)(4326008)(86362001)(107886003)(33716001)(6666004)(9576002)(2906002)(478600001)(9686003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thogsQAb1xuu8NMFuuvQNzWIIs6sSdwqxansG0sedyX+x1S03O/MSC9c1Aqch8Av5z97yx/Ak4bmyIB4wCPT/AUjijBBBDZpFEdWl//FZY3L28/+exnYEB+KlTaklzHAvTvB5SBcA+UWiflz20KTokT/YACsMte5vLUKItTgxSQYh1bgcGoZc93FOOztQQOIWmGwQIVEaX9UzadndVJwpNdvLmAF5x0axFhWse9/55+h9+SemQPquLkqjXqhdkof7gProXI25N4QVrY5BjwqGAhU7EuqlMQtf67DHy+RtQGt7JbBp//zNAIZ6n7hETUQ4AgrJEvDlHFpxgNTvIBIE6JcNKB7uqVfqbaLKAkrzAqtYZU6wyXX4ZG6uBqT/OYhjXQD6yw4WSXwvu/M4mUxxQDy37FExlb2rZFxQcyOR1uZcAI4/NeOvqZgCtrtHXU9
X-MS-Exchange-AntiSpam-MessageData: iDEZbOOIVTW84WFhzyxRObgRwwBKwER+ptCiOCEdyn4wFHDuI/aX+HlAIx2froRy5JWtP95K1eV5dFeNdoLLLafU7dGIwVYDM52thTcDmWNhCtU4cUd9Iao9POI26YtOyS+J6E8L/XC1P1AfA8LrEduWAmMV/x75Nvp6NwHlKXMJTFL5tzWWBqTKqvF/PrDLGUzn+SdygZ2DXslrwYl0MlUznitE/Z7RvoupuRu8X925iYWritQ4zgwestpH6QtixF3Q13BSOqVZtrBYQUtovMDabqDfTpAIfFsFRL/zMo9zS6DqvDLbRnSpvqjK9F0QD4mZmSNOdfvv05VjjRrXnmBB3yPL1nDMlp3KjPl31N3etSyzYT5x3tY6JY1NBwgrIULBOXhoxN80jNWKnRy6SjeLQiIrTF7TojmXOkqZAJKfWej5U5gjzy9NwCDCRkfgjOr3PJKlOlSku+wTzVcXhmBd0Jas7ILjTj5/b67qKeK3JageuwEFM0AM9qtT3wB/9M/ItZYZyQn77Xu4D8ek7VZ7SsuyyHZlaI57YrX7ifRbdQiMs0dHX6SKO+8XrDSP2opszgrptR00ixQJaAzxXhSHN9uxBi5KIlPaVs5TC/HejIzQhsUwAzvh5R2r/82X+nwF3UCnZqbjjgyCIDWN/pu5OFQUayvDsdRNhq+lnjv/K6+/pBQGmHp9WAtJMKSfZG48zTy0Jid5j5EhjXlkKmYOPnk/vqLw03lgDRMV6tPOzv+3MGpDS4f6ng2J9Pd1HC02Admq5H4V8DRTAg0PCc6W2r5Y7hDaD142xT9hcl8=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5979c943-c2cb-4943-a0cd-08d7e835e268
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmI1hwTcnXEtkudLomyru/mPK/QuLoUayChR7tX/gWfJPwON/I2UOTR1O5FanOPknO5bN4XzgXxi3SZPlmgJryKUlUWaeTLIHRQvmvOJlohEmXDpa/e+1gdHlONSUzh7suDUkOhVxDBzCbXfaT86lAz4DxT4vMW09EPkBy8Cdocdc8yt80MXqdZ9OcBD/Sv0nfw5sDddnK7yiQCWScIBmXgQ+NErU1GN8pXiKas8aUM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 09:58:04.9583
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2767
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240078
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > Enable access to the wireless card in calibration mode using service
> > ethernet port. Wireless functionality is not available in calibration
> > mode. Service ethernet port can be used for various maintenance tasks
> > including calibration, configuration, troubleshooting. Add new kernel
> > module parameter force_svcmode. Set this parameter to one in order
> > to boot wireless card into the calibration mode.
> >
> > Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
> >
> > ---
> >
> > Hello Kalle and all,
> >
> > I would like to add support for a simple service mode for calibration.
> > This patch includes some controversial bits, that is why it is marked
> > as RFC. Could you please take a closer look and tell me whether it is
> > acceptable for mainlining.
> 
> Is there a reason why you can't use nl80211 testmode? The use cases you
> list were exactly the reasons why we added testmode to nl80211 in the
> first place.

Hello Kalle,

Thanks for reminding me of testmode. I took a closer look at this feature.
This is what I would be using if I had to implement calibration mode and
tools from the scratch. In my case I have to deal with legacy behavior in
calibration mode: special firmware mode and tools that expect simple
network access to firmware. One possible option would be to provide a
dummy wireless interface. However additional manipulations with carrier
would be required to bring-up dummy wireless interface. So I ended up
with a simple ethernet based solution.

Regards,
Sergey
