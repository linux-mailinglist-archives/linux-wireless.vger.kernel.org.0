Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00EC1DAF1C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETJo0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 05:44:26 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:30500
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbgETJoY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 05:44:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq3fGbXQnlCgZfRGQW9j4EiginBoGWFfz6iGWvpy+2cD2BulsovKGiPeUjFEU5HUfRi8KWPAFl7LoDHnor+EaCSvS4EW00k3D0/m48EjAAjR/I8nVyjDvZnkQ0G4OyG4+aAYimG/1t8NZHDpQCm6i7JcQ34tV7N/dxUao+xK1qYOeLQlcQpdFicDQ7HkDnMtjesdE1tt6CMDgnjURTC+lRNsRCyEZTKRD6VpIMX0q7AmPRSqv23CLFHuNoeVgU1br+po5gqM12r8obV8DOZt6MMGPskEI/iy2AZTeJygE1mwX2pgMO0rbroU2/X75rq9CrRhsgoVgeDhJjQf3RLUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhpIo5IXICZCc49okWGO7vquKEaBVysIZkHXiyNK3SI=;
 b=B+QNYldStZYn5NJhKzSWtpi3Locg86nRdYr+HEr0G6j6jNxr3GW2MjJJQ4rBs5HY7rLA2qZpqC2dSYKen0ygYji3z28/fb2jIzWjDfacoLE5mtdJf9EyfSF7yBsxdnta1s3vY0L859+lI3gL+icnOcDg7JRQWwQHILiNJl44trTHfZbI1/pAeUvd6LILduAR1o82AoJ524UEums51y/ihN/bhLlqXZ5rMR77R0tH4aKCsTs6vMm15tzzNmBZGlHwb1AyVCIqlBJ6Flj998mqMJQBejgLaX89kh08cnGSBRjlz895W2fYYHYjb6vLgsnd+zbkFVCLmq6V06yUmDzPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhpIo5IXICZCc49okWGO7vquKEaBVysIZkHXiyNK3SI=;
 b=QT5FsSea6nEwF4HFDTSyNI5O4BO9DDQs5KULJLep1Vyn0gMWHkXmqtEZgyWIaK0OGWRTIkIKKBvl41gEzK1mOJlPkEkjOv4556a8D7uiMy+DuedOhmrspGofnzrxnNKaGHQwts+ZlZFN82WZb88T9r/Wzy/O8hklrtBLaQxbsfg=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nextfour.com;
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com (2603:10a6:3:f5::14)
 by HE1PR0302MB2652.eurprd03.prod.outlook.com (2603:10a6:3:e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Wed, 20 May
 2020 09:44:20 +0000
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::b10a:8b9d:1a18:6b2]) by HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::b10a:8b9d:1a18:6b2%9]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 09:44:20 +0000
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org, linux-rockchip@lists.infradead.org
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Subject: iwlwifi firmware loading problems, rk3399
Message-ID: <9122588d-683a-936e-1305-c34124e6702c@nextfour.com>
Date:   Wed, 20 May 2020 12:44:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0235.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::11) To HE1PR0302MB2682.eurprd03.prod.outlook.com
 (2603:10a6:3:f5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.10.99.2] (194.157.170.35) by HE1PR05CA0235.eurprd05.prod.outlook.com (2603:10a6:3:fb::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 09:44:20 +0000
X-Originating-IP: [194.157.170.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 297a1b3a-eab8-4942-37aa-08d7fca25ef7
X-MS-TrafficTypeDiagnostic: HE1PR0302MB2652:
X-Microsoft-Antispam-PRVS: <HE1PR0302MB26525B5FBD492F5BE13855D283B60@HE1PR0302MB2652.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9TSfaRDviHYV6RRrBOEmLFwlOUpjoE8lyguXUjedKqnEX2qEgknc5gcZoXE9h21MzbxWudwtM9g3Dm57k5y5+ZqkXtoaA5CI4b/fzbr6G2ioSequxeHP7Ic0sf9FKxoqRIyQHCo73KmyoO120qFOW9qHByfg6HqkPGLjIK/3stbcUQUpIzxeuv/w7kxP57w//V2dJB75xsZFJ3qjUxBibfecdpYbZRz1xeFrL7cH+jgOhpqx3XGEFyvCKeV2EChv1x2pDWoj3Jbu1CP2aiuKM3x3g7noieCzS4tI0+yFMCiFfh8wN8jLAXPYJdN24NMJYfTuSZ4fkgmLFaoEsVDJzIv0nmdULITA00elzDn8JpZKNrNx1vfUmtsWJmZaxzlIFFUQx4Wuu2GzIaEQlB6+n2x46cYG+lsZdscPHsX33TktKyTtT8O8B2HiWkQ5brgj8p37T8mxXpfNv+nzr5PnOSteG+XbXNTwXlQQu6eW9d23m+9jLqAI62xPhFqNW6R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0302MB2682.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(136003)(346002)(396003)(376002)(366004)(31696002)(8676002)(2616005)(956004)(52116002)(6486002)(316002)(86362001)(16576012)(110136005)(2906002)(8936002)(66556008)(31686004)(186003)(4744005)(66946007)(16526019)(26005)(508600001)(66476007)(4326008)(5660300002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XG1O4KTqhPk3gW2Mdo+Z1E09CIc1vdTalMcMCa2kYKgvjIsak8rW+xYHHjovZqPYK0G3K1TXj3H6bRhIX9GE0IhWy9+sW03i7yz2QsniyN1Fpm5BEfsZZC7zT5vpAYmnux7FoY0u0XI0um6GhWIoVaCPqi4TT6XuP1c8q6djqYJzQxjZY6/P3lykHXIOkkgxthpgRtwWRgoA+ZugGiw0KhrM42xCsU+JugCKCRb4QaAdZjvd7nVZpTULJWg9mnlzl5S2zKTFEr+kvGB8Ycvx6mK7uBRl87Ewn5M5tu0lEqF9EdFJsgsCcMr8pQZyogPaGzvfBHn0AUDEP7DBR3u3godxYXViBM7NVbr/Yo9YGSc/Au/8eu3Ywt24ThduSiVDUYi1Xn+D/fvzbk6rGthnV+IDHsdLepoNEbmwiAKZ83T25cpXnb32en/5RMcTdE8a9R7iC4XI5VCRz1pliCvRUu3S0FELzsAhNWccJfvkZinjUgM508O2PvsR3FFBJT5V
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297a1b3a-eab8-4942-37aa-08d7fca25ef7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 09:44:20.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsfbVDY0iMzNNon98Zhx9pS1lPZ95wrGp5J9YzJUPW58yYvxNkKCkGgoLOCHaS79a2YJIyV31mSj3TgScFg7fV4srjL8ySHdX+Xyzq0rSf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

We have custom made, Rockchip rk3399 based board with a standard M.2 
socket for wifi/bt card.

We have tried man different cards, like Intel 9260 and Intel AX200, but 
are experiencing problems while loading the firmware.

   Failed to load firmware chunk!

etc. I have a little debugged and the problem seems that the interrupts 
that acknowledges the load to proceed, is not coming, randomly.
I have tried many firmwares. Do you have any pointers where to look next?

Thanks,
Mika

