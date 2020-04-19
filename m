Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79D1AFE3B
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2020 22:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDSUuQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Apr 2020 16:50:16 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:57858 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgDSUuP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Apr 2020 16:50:15 -0400
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03JKlICn013190;
        Sun, 19 Apr 2020 14:48:22 -0600
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0b-00183b01.pphosted.com with ESMTP id 30fvsbjpk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Apr 2020 14:48:21 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klX9ifAHJYtMeh4FV7bIqHuq0SqsirfmVWBkjmBuvDsNnZLHQUlGND3UrPb9ZGRGkGQohIWTnWTOdfR5cgld3K+yGYBHIJbG1HUgGg8K1Cj47eYOq4iCx8VbwmAHC9bHazJfAAGJZCJuyxOPz6t0MFowe+f2NzSGZB+HQXzUugfhKfp4S+93xKWUajyiFRe5udPKRng1IobJmtSG9kpjLV68O3v1VNxiTXGrKjPm/Of1ftMlJhALrE1pPD6knDXaVNMAFDPRJ/aGBZkm6Uguq9R5idrvm4Z+qZ5H531msNMaDCtJK/jfGxgcYYrFKSsYq7g7uEAOB4oXPI3oO8g2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tphpv52QTiOdDVEu6plQ6nscdWl2ShZYq+3ARW1He04=;
 b=AohkcN8Z1DoXDKpLsb/awGb/jFFCRHFD1pDazgnpFkh8F3ZrFfSeI0O2IIyBT9XvNt3H0249PaS5Q+xOudeB91IrzcgUV+dJxE93TSqPdi+6Ml8JVUyIdAkUUebh5JJSscUVMxsy7dFZUTG/+qLCEhbe5G3sIXcu3qZ5c1tLfo+LPEmcTGw4Ewz30pPvTIw/LPyG2X4va1bMHyOV6m7M9IEPDPGTeLldfpcnU+03QV0Phh/VX1fpLaGf9T0qcQnJXI+fbZ/n7S5s72cwLzal3KEQS6xWhxTbDH8WIIWpKjO939vB5GGiUJ4n5R7n9etfHdzD4vzAOocy3leOVOyBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tphpv52QTiOdDVEu6plQ6nscdWl2ShZYq+3ARW1He04=;
 b=KMtQg19Cw/B9HtySAov8Wlzj7knyRFvYoGpcqslydqeN//rWzLpYWbas82rKEX/A+spKXXxH9lURlf8h3RstJVoaBjySoH//LPayldQzVNfWCsihsKbsZQ1BuhFarEhjYs388QLfI6v2tpss7bW13ClnSQogO4A764RlFekMb4A=
Received: from BYAPR05MB6600.namprd05.prod.outlook.com (2603:10b6:a03:ed::32)
 by BYAPR05MB4582.namprd05.prod.outlook.com (2603:10b6:a02:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Sun, 19 Apr
 2020 20:48:20 +0000
Received: from BYAPR05MB6600.namprd05.prod.outlook.com
 ([fe80::55dd:519a:213e:1621]) by BYAPR05MB6600.namprd05.prod.outlook.com
 ([fe80::55dd:519a:213e:1621%3]) with mapi id 15.20.2937.011; Sun, 19 Apr 2020
 20:48:20 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3207.namprd05.prod.outlook.com (2603:10b6:903:f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.9; Sun, 19 Apr
 2020 20:47:37 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.011; Sun, 19 Apr 2020
 20:47:37 +0000
Date:   Sun, 19 Apr 2020 23:47:30 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] cfg80211: change internal management frame
 registration API
Message-ID: <20200419204729.4rg6etlfzvcnwd32@bars>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <20200417124300.f47f3828afc8.I7f81ef59c2c5a340d7075fb3c6d0e08e8aeffe07@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417124300.f47f3828afc8.I7f81ef59c2c5a340d7075fb3c6d0e08e8aeffe07@changeid>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM0PR01CA0123.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::28) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars (195.182.157.78) by AM0PR01CA0123.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Sun, 19 Apr 2020 20:47:34 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1edce75-d479-4bf3-2754-08d7e4a2e4c2
X-MS-TrafficTypeDiagnostic: CY4PR05MB3207:|BYAPR05MB4582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB32073A00B7B0BFCF4788403FA3D70@CY4PR05MB3207.namprd05.prod.outlook.com>
X-Moderation-Data: 4/19/2020 8:48:17 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0378F1E47A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6600.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39830400003)(376002)(366004)(136003)(396003)(52116002)(2906002)(54906003)(4326008)(956004)(55016002)(7416002)(316002)(1076003)(9576002)(8936002)(5660300002)(33716001)(6916009)(81156014)(8676002)(66946007)(66476007)(66556008)(16526019)(186003)(9686003)(6666004)(6496006)(26005)(86362001)(478600001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCNSDw/MNM20DDA59aO4ug9LZxQHpR9nwTY3oQnC0VFrynTnGgwxfrt9ak/wQYn2IsfvL7AKALS9DUMQQELARg31fgmob0FiCMZ61us47XqM6ULXAa+AtQa9oe0IgAU5uho5I6kPjXnMvrgysPYgB5bcaU3g6RPlIlka87va4zqDz2cVY2LGNeMMmihGk2MQg2FXc7I6slgOJP4fh2wzwZv+rRSN9VcJ1ClizXbbJVQI9+vmj66USA8FwP8TYero+YlJQ3K2t2ZVoGvoikOCEZd1+mzsNuHLRw1roTta5REEZo/uQzZuW6ZVF3XtFSqBY3SjClTub3UxL31bfLTAab11AidTzHeKpXej8Uckm8Nfs0wXFAA+Z/1cmK1H3oatiKQzVJYy/hAD1GY9rQyjUPTAcbEWR6vIbWxMkgoG3V8RKxAw0uNj8DtaDWdmc2qf
X-MS-Exchange-AntiSpam-MessageData: TKHyBy+/czBAJMri3WYn4fPai6YaJNH9tkFdYJnlrNo+6oBE6FCCCCAsQJahY/Gcu0IfHH9fIA4B9ja/e5VEkimQp0UF7TKF8zUE4Z3IpajP3EHK0Xfqtgou4sgKXWjm40t04OkHcipB5BMPk6fBFA==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1edce75-d479-4bf3-2754-08d7e4a2e4c2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0e6r7gV/IHUUaNMoWHa28JZ1DjkiAGQMuRF2Ha6NXPA4KkHtzfo06tM0yawqNa0f/eQgS/PLq7ibCfJx6BxIGobRASnAWQotJNyj50MVba3fHrCc2eKRWln6KgQfNo7lCCVEyysSjgFkegKw3JHfyOzbUK7dUH6wK7JKaW04/yv1BJb1unNmFb4n8usQ0CqRL+ByeP3q13WJma230wKVOGIZkf4M7IZPYulpBiRHQRs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2020 20:48:20.2891
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4582
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-19_05:2020-04-17,2020-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 lowpriorityscore=0
 suspectscore=2 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=915
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004190178
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Johannes Berg <johannes.berg@intel.com>
> 
> Almost all drivers below cfg80211 get the API wrong (except for
> cfg80211) and are unable to cope with multiple registrations for
> the same frame type, which is valid due to the match filter.
> This seems to indicate the API is wrong, and we should maintain
> the full information in cfg80211 instead of the drivers.
> 
> Change the API to no longer inform the driver about individual
> registrations and unregistrations, but rather every time about
> the entire state of the entire wiphy and single wdev, whenever
> it may have changed. This also simplifies the code in cfg80211
> as it no longer has to track exactly what was unregistered and
> can free things immediately.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/net/wireless/ath/ath6kl/cfg80211.c    | 26 +++---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 19 ++---
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 16 ++--
>  .../net/wireless/quantenna/qtnfmac/cfg80211.c | 83 ++++++++++---------
>  include/net/cfg80211.h                        | 23 +++--
>  include/net/mac80211.h                        |  2 +-
>  net/mac80211/cfg.c                            | 50 +++++------
>  net/mac80211/ieee80211_i.h                    |  2 +-
>  net/wireless/core.c                           |  7 +-
>  net/wireless/core.h                           |  6 +-
>  net/wireless/mlme.c                           | 72 +++++++---------
>  net/wireless/rdev-ops.h                       | 11 ++-
>  net/wireless/trace.h                          | 20 ++---
>  13 files changed, 159 insertions(+), 178 deletions(-)

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Regards,
Sergey
