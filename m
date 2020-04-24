Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD821B71F9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 12:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDXK3D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 06:29:03 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:47824 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgDXK3C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 06:29:02 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OARHYK017580;
        Fri, 24 Apr 2020 04:27:17 -0600
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-00183b01.pphosted.com with ESMTP id 30ka133qua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 04:27:17 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghGkclRyXX2uoSzPLehaOHs5JD89Jm5sztmeo578GwkpHPwutzow45JBjHYTvIlwnccgcBwaCcub48QYthlRPRZAOzFGsy/OWXZ7BDe67+Pp6BFr2ZRCYz5vIbGxXa37ErJ/fT4RHFM9tCLTcwroCmfq7eUf0Emx76D5/lD7Db8tD7KD7HZZosVS1qCniDqBOInnlHzyxuWMlyNBSBQggXdPeyvuG0w1/zFa9dtuk3HqE1IeNBVjmuLiisSUVhXFFaYV//34h2yKOKjy972wA16uQBc7+OcWumUZkFerWjWd+OoMtoCEnEp4HUOt7FyJZVdZH4emv8T8rOCvJzaAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2h9zB/oysKS74DuyHuUTchG5UOX6FpzAytLUU1kG1s=;
 b=FrCC5HM+0eqIDq4RU2J5hhfRiWx226Rn9d+E18BOLfUlCgbxht46JneB1xvbmVwo0p92GO5aWnCH8Fa9OsYLtVsq4imIgkpzDFIjfenDg8vyH8VZNnEBEYEOl4riJ5bT8/4lt0fwf7Zu2LAwPt3Ut763EnyY7efSRpGzwrHADH2A0QIly/R36r4+OouRj+15xhNGsbX+c6Slsx8bJYY0a9d2ScvOgLY9tDeieRyeEdgdhGCzXqn3XsY4M+AFWEO4Hn42zCw8K7O2bJBg86soOSfbin0HMK+F0DUCOdtcsk35+6mZ2LgfYvMp2mo3B+DDjHnVRSUjJMD31lbUBi3KLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2h9zB/oysKS74DuyHuUTchG5UOX6FpzAytLUU1kG1s=;
 b=MxbLFec0oXe2/8T2NuMbdztdV/bGDr3ijLUgrP6bO8U5AkbPl6zp7433KdaVpAjGQ19YLQZnBRqcqUnfVRqsvtncHLmpnN7n1Wi26t746Hz5eEKY06rpS/REoL3JdRqV1UKfN6HWU6SQBrZ4lUcwaYByIXWKBEeUwdcytOGPNTQ=
Received: from MWHPR05MB3215.namprd05.prod.outlook.com (2603:10b6:300:b1::15)
 by MWHPR05MB3311.namprd05.prod.outlook.com (2603:10b6:301:3d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 10:27:16 +0000
Received: from MWHPR05MB3215.namprd05.prod.outlook.com
 ([fe80::1ce4:73e0:7a6e:9823]) by MWHPR05MB3215.namprd05.prod.outlook.com
 ([fe80::1ce4:73e0:7a6e:9823%8]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 10:27:15 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3304.namprd05.prod.outlook.com (2603:10b6:910:57::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7; Fri, 24 Apr
 2020 10:26:43 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 10:26:43 +0000
Date:   Fri, 24 Apr 2020 13:26:38 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: Re: [RFC PATCH 0/4] cfg80211: updates and fixes for TID specific
 configuration
Message-ID: <20200424102636.lua5qdeaw2fkl7kn@bars>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
References: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
 <db1081861ba7e7ee334c3e50494ff3cd34d9963d.camel@sipsolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1081861ba7e7ee334c3e50494ff3cd34d9963d.camel@sipsolutions.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM0PR02CA0009.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::22) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars (195.182.157.78) by AM0PR02CA0009.eurprd02.prod.outlook.com (2603:10a6:208:3e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 10:26:42 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 783e0f85-2282-45cf-ad7c-08d7e839fbb4
X-MS-TrafficTypeDiagnostic: CY4PR05MB3304:|MWHPR05MB3311:
X-Microsoft-Antispam-PRVS: <CY4PR05MB33044E7DC397FD74F7441E97A3D00@CY4PR05MB3304.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 10:27:12 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR05MB3215.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(39850400004)(396003)(136003)(4744005)(316002)(5660300002)(478600001)(6916009)(15650500001)(1076003)(2906002)(956004)(186003)(16526019)(66946007)(9686003)(81156014)(9576002)(55016002)(8936002)(6496006)(33716001)(6666004)(8676002)(52116002)(26005)(66556008)(4326008)(86362001)(66476007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAHvRIKc2uV91bmm8m+nFHhAiQGTUerclfHg3aTabL9Wx3I9dKk+vHR9x4NkFLLZLeo/dDOhTLiqcv+0DSWco89Ho/t4sWbqIqxEiSqPYCmON7j/zux4UkSLkV8ItSIujI0yPMdz7/9aQq5vWVunhV0J+AeQACsEot0+VT9DaR5cz3nlgtEOn7wMIb7i+8pU2Fs+/2DBm1Tw+Su/UadWSycc7iCh1sZM5IFNxlzSf4syW9633zZiNL7DWK9hxDCAWm4WlLDxwfa78TRLaEx2M+2ZbnyzasNw2Db+8borti/KbQonCoqjSGjQ4GiRW/mE0RtFgQW2EHUOTMftm85AX7cyuizm/arlLD3mOzA5RFPT+OyTx/fHxIUvgXLE9TjV0FQHrBceoSW+Do38hMyMmRGZysxvhrUF4jHovSKM3Nsa+L+yVQ++gLB7IHoPyq7u
X-MS-Exchange-AntiSpam-MessageData: AB50iSCAWCGLUftesvscqzYQlRvL0CheOtjRkyZVydZWv5jVQR5fNoY3iQyHYtcZycM6i5o9ylxg703Wn1Y8uMGbSBjOpWn6EGMxUl/I3buKxdOeO5skoSlG3Uc8Q/uv9Q/DaCyIvZ/iK6mpO4kCu0+jmwh8gJ3Ljr2YFH97gS+aQMszW7Qngzt/qy5jsLfUvyId75mXvWCbTLQTpDjc25aVWApa22cAqcGVB1U/PdJeGjfzcrPN3otL2z5PtKXi0jigv7eVRsZU7S28AuGSnoLg5YMVOuvE+Wb/9DxgzpLJN+b9hIzd6bjCmyFZDqO6/w8JUi7JwkFqBSXURp/Yrjo405S7LFKBQHy4saJzdfvipHskQ3cObhVsB6exvgurE9yt2QZUuOtvRt8hkgOb2gS05WPaa1NUR7V3z59pZlEYNasOjVuEe5A71gRCwmxSk5Ks13u6wSjhilRu9NOTHNn1OiN+3G6vB38WAqzbl596NaJo1V+EdThwXFNfcj6nHTyW72DyzYu3tmHhct073/3x2S0tuqpRuWtBDOOcg3UE9PMhkaySYfkuWVpV6II8ElUET3Gpu1uafV2WuXVFcLRoNb0+h3pANU8Kub3ZVytNyxkQqInJ1U0ZuT72P3S+WgpN1egWY2sZPuaO3mrkXZsispePPDbBjYL3KmLelTZl3O2a5K86sHUPm/yhlq/G4QjxuR2PjBeVmF+FUWgqITuwf5AHfTn0XlHZ97ue0DQCXSlgEmBembpUEE8kFYmvAHGvgDYYYYkz+riUSjAjgENWLwLkVC7sxAmUKDvAGMk=
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783e0f85-2282-45cf-ad7c-08d7e839fbb4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa6MkpDowxvOlg/CuygO38uxUkaMZQM2mC9Fn+NV11VpVQ+ZLCCQroBD43M9E09fE2zgNaLjjwBkdcKIwQ/6+uVyc/QAoXw+OqCiYMf9i6ZIkGy4JJi+/nA+tANHpgFtM+pfjFoH30pGnddF77M6aK80PndoKWRw0vSpClc7/AdjyY8SEeU5jHM5DT2EmhKVvRb3y2hJQIIaTtStDqgckA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 10:27:15.7411
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240081
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > This patch series contains several minor fixes and enhancements for TID
> > specific configuration functionality. The first three patches include
> > minor fixes and TID specific AMSDU configuration.
> 
> Looks good, though I just saw you noticed a small bug :)
> 
> > The last patch is somewhat controversial, so the series is marked as RFC.
> > The last patch simplifies current override logic. It suggests to make no
> > difference between 'specific peer' and 'all peers' cases and to apply
> > new TID configuration immediately after resetting the previous one.
> 
> Yeah, I tend to agree.
> 
> Can you resend with the small fix?

Sure, will do. Is it ok if I add a patch supporting this feature in iw tool ?
Or you would prefer to review it separately after this series lands in
mac80211-next ?

Regards,
Sergey
