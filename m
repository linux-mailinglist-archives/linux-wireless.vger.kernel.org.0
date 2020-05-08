Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76181CB5A2
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 19:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgEHRPu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 13:15:50 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:59670 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbgEHRPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 13:15:49 -0400
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 048H74K6013329;
        Fri, 8 May 2020 11:15:48 -0600
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by m0059812.ppops.net with ESMTP id 30vtbytk98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 11:15:48 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuZTOOzpR7Um/MnumBN9WJp9kJso4nLtYCKJ0eiTzNbFuwHXLLzwtisIJiDePFTFM734E9TM10O9KOGdAeRe0lc426wD3GfABid9XD0883gvtOWGr9Qcjl0umORkZ9XWmM8JZQzUmttr2dz0i7OBYX9WnCBaJYAUUZpLKTzCXgemuaYch3rs7kBB+HEes6D+40PvfYkB6VoGrslZOfZsDi22tRfcR3GJJK8s+pVlBboq9B9KPfFllmFQSTZAAJiiD+yLtkHjaKx2X1+XBRrVlQDwTQR6mHopjc9CFaX9+by+3sZxzszzeAJJHJPsScQDffMygmfwt5k9WE8R3QwY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8iR2CTSnP/Sg7Fkwxhu9Bp2FhDoOEoBcPKK9ruKQVE=;
 b=h4YFg3U1GZ8asF3tW1NeS5w9ePTcgK4BBeFzICgRXdQJU/p3MOYFPkk8lcikJkGl8imM/JCv0M0TPPU+b5Se9+xMHU63i6YvYornWbuxjCgfovJB/8G656N4obEbmr7KhSG/LDdWIw7V7cbMGfjskrpuMPciD1yzsPWHqBQlzyj/82ao8x9yHGsZ1cLgoK+gvSjSqWpj4aHI6fI/UCdZ+jzOBMJhKZM447tcUNYHG6ESFhhuMmd8CwGKKC8Vt6cVwIcjMuB3vXY4/d+IRq9p7Wpe01g5CCug0u2y266rhI3VA6nMa6703P88vcfjwKIPBwd1doMzYng4Hzocx4TtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8iR2CTSnP/Sg7Fkwxhu9Bp2FhDoOEoBcPKK9ruKQVE=;
 b=NN31X8lmlFkkJWnxAzlg5bKla4nrwFjao3gmDxEK38Z7Bt6Sjaa1P83wXBAY3nelrPDEO7vP247l/veYP7fB85oE6VU14n78+HlbqmJ6cRIVqI6h+a6/VCbC9cTgDkr3k3QDNxYDQsjNIqyHvpp2NNagrZXGaWyKHa3BrHcKtJc=
Received: from BYAPR05MB6309.namprd05.prod.outlook.com (2603:10b6:a03:cf::22)
 by BYAPR05MB5655.namprd05.prod.outlook.com (2603:10b6:a03:1d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Fri, 8 May
 2020 17:15:46 +0000
Received: from BYAPR05MB6309.namprd05.prod.outlook.com
 ([fe80::d8c0:3fd8:fcf2:2221]) by BYAPR05MB6309.namprd05.prod.outlook.com
 ([fe80::d8c0:3fd8:fcf2:2221%3]) with mapi id 15.20.2979.027; Fri, 8 May 2020
 17:15:46 +0000
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=quantenna.com;
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3157.namprd05.prod.outlook.com (2603:10b6:903:f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.22; Fri, 8 May
 2020 17:15:08 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2979.024; Fri, 8 May 2020
 17:15:08 +0000
Date:   Fri, 8 May 2020 20:15:00 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qtnfmac: Replace zero-length array with flexible-array
Message-ID: <20200508171500.tqapwgllo2qeynpv@bars>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200507191926.GA15970@embeddedor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507191926.GA15970@embeddedor>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM0PR10CA0038.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::18) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars (195.182.157.78) by AM0PR10CA0038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Fri, 8 May 2020 17:15:06 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5225123-9922-482a-fc57-08d7f3735b66
X-MS-TrafficTypeDiagnostic: CY4PR05MB3157:|BYAPR05MB5655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB3157F8BD2B173A570694A9A0A3A20@CY4PR05MB3157.namprd05.prod.outlook.com>
X-Moderation-Data: 5/8/2020 5:15:43 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTDdbhoDIRu2lBkgsRtTeI2k2mfdFibUm7URHYY4AJhsRotT36m2zCD+R6DPo8xVHZIOglGm2g9/+c6pOx/h8bNRN84BPmGcNDqf4k97Xbu3T0DkQHA9jxoxsUFuXfe7STeJZ6ZXcSrhBU6qYUKe+/Y6aCw5AfLIV57hlsKyqSMWlboFm5uO3VTmr3ih74tUVhcdo/2jDfrwjbYMQ7HVqPucci5aRIBTy8FueBhiui+wnZcVys0TqXZ9O2hh4qRfwmH0YKiXb0CV36XxzVteXUmDfgDbyj78FSabejaNKsXUpYsfFP9i28d4QnGHvgSvWkeBWhEtRSnk0IgZZRwk+Q6I1gFXsGtzFEtCtA2tn79Qys/u0NR2cb9wCQLgrBn7ZCwxfEIxji8cLe0qeR0z5mU9RZhf0NtNsK+xX655sVAzmOhKRAQy2f4XQgrdU35y9sQRE4//siQNPD02BpYbvCjjhWYNS/k30XxSYjQgJuO81MtInYTUrES6zKXSO7ctoxTUMgNdEpiK7ED/51lihw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6309.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(396003)(366004)(136003)(33430700001)(26005)(186003)(2906002)(66946007)(16526019)(33440700001)(86362001)(5660300002)(8676002)(4744005)(956004)(33716001)(83290400001)(83280400001)(9686003)(83310400001)(83320400001)(6496006)(55016002)(478600001)(83300400001)(316002)(4326008)(66556008)(1076003)(6666004)(8936002)(52116002)(9576002)(6916009)(54906003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3JMXuD2sw/NAwOumvKDxaFHoRqdxFEuIFZSpg9FkrdTc6K5bGbbp6YJjM2VCnvmqcxQzACWOpKxQrLuwpTD3aesH/zAC+ci4a1QQyHWTrZLkkv6BboAtLDyLCUVHiNtcEjCH41cjeRCnzeAvtu/SUZ3XqDUx0Q73a68xVtTdlG/AmTb4Rgre1YtNbPBzpwNhL/0dqGiduGmQpMm2vs4NQs97o1Uz/YJOi7I/zidACUY4jdMMC7IeSqicoNxyqBnhToOxSEpa9PRks3QMtWKm3zgrU0jWykDJpsUbsFt1qRqEqqP2w5DzJlQjbcBM3dLjadKnIQFJS/CgiPZo83hSVGOmNMNpe2Fi1Cvu9v1pz3tBsZMj2oXIqbc0rXCgi6UmriOMhH4Ber4wHLuA6ZMTfHXu5Rb9dUtlZKVwzhpkKAWdDz9fzr+vzCouXL/0+ebdqTAXPnF6VtWUzj6djsXk37XzS9sZfjPMLgv6Td9vNf6NJiM9pO7jykjWZgJczSqu
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5225123-9922-482a-fc57-08d7f3735b66
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5At4DZn44YpCgMcfoJVwxaAy872Q2i1HqFUf9hE2voR+FotBpB0kYUappgagIO1/0dnNjra1i9yEnTRdI4eLkx2ivlSA+sSbmQ1XNPEe4BpdvsUFOE6ifO5J86qJ8BQq7+g5vT87P2cYkQQutfzf/Ybb9l5MLHrrxeLQY9Cp8Q6avtXIw1zaoBYoiPfzo1S5VNpjgYvnZf+g1hHGcMXQEQWJhEIpDJyZvPEIXgUZ4zc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 17:15:46.2558
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5655
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_15:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 mlxlogscore=351 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080145
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

...

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/wireless/quantenna/qtnfmac/bus.h   |    2 
>  drivers/net/wireless/quantenna/qtnfmac/qlink.h |   54 ++++++++++++-------------
>  2 files changed, 28 insertions(+), 28 deletions(-)

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Regards,
Sergey
