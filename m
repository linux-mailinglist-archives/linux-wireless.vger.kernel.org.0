Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DBF29EDA2
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgJ2Nwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 09:52:40 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:40536
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbgJ2Nwj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 09:52:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKYEfQi3c7SBlWtaDQ2CBiOXymhPbxQPzIBHW7YyXdq0uZbN2M+QxEn4EcrDUWm5VR4DHt/q5YFpOavsA5JTocMTsJsE12qEInWaErSWEF5S3eIXA+ySxdt41g5kMb6sf3aJzL5wPj4ASzOTwYA+I76LOSiTDPvmgTM326PVwTLejup3YqbRB+FYKURwREy3/QHPoH+JNraOABXZohv2LiRXTXXiB3t1/VNpDHPB8lsmQEPmI060U0QPCAo92R3fCkMzgM/TO0jRlwKrxKiCx9zGymsMhE+AmQ+pWzwhRSZYs5ow7G+hoBi9VyKMAuBadH4DL+MLLMkDzNuasJ8AdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXrdRTTPtu0hlZta0KsrFYFsx6zNG3RfVAsyDMv+iMw=;
 b=hcjiivV3AVZ5+LM807t9A1dPLVgtrD+cQDhEI0ptDGUo7fhz6ZPa5SCRr1tUQwemQPRuqvtIb7i2FGDz3b3yUy1ye+jPukLMW3/2pthrt3DFa1uLdQ/EYtHwpovhs5osOTODpD9PRZyyhJBZbOrUtUkAd88oL23JgjsrO3t1XO+WvJrLJYyeC8IbwSJluLDP/hbDplLTr6Cm7D1rvUchzgAxglKQ1pp/MJjuHG4mVT1XEmCForSrHsNvmKobX7N/OiuJIN7RXqmsvRzR/bnFJDbBwScH2mHkujwcfl+O1tcs5KRuRALk42FWFV9Bh6zskHE8gZ7Ypdy4QUx3PQe1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alum.wpi.edu; dmarc=pass action=none header.from=alum.wpi.edu;
 dkim=pass header.d=alum.wpi.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.wpi.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXrdRTTPtu0hlZta0KsrFYFsx6zNG3RfVAsyDMv+iMw=;
 b=DVr9N2f0rwPSGYpsFjEC6ZE0KWlJ+YnqH+z45zo+cswK+gn5OtDCq0JtXz2uF8rQc3j6AmE1VuwqUSw8ZRP7TdJ3xwgF7flYwyIJaMqywI8gaK4AgFSQrswWoeedHHjc2mNZrbYKU/wE76ncm+OV1HuMkzJOBTODuxJYz1nNoK8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=alum.wpi.edu;
Received: from CY4PR22MB0392.namprd22.prod.outlook.com (2603:10b6:903:b7::19)
 by CY4PR2201MB1126.namprd22.prod.outlook.com (2603:10b6:910:48::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 29 Oct
 2020 13:52:32 +0000
Received: from CY4PR22MB0392.namprd22.prod.outlook.com
 ([fe80::20c0:ced7:76fc:f46d]) by CY4PR22MB0392.namprd22.prod.outlook.com
 ([fe80::20c0:ced7:76fc:f46d%11]) with mapi id 15.20.3499.019; Thu, 29 Oct
 2020 13:52:31 +0000
X-Gm-Message-State: AOAM530llpcEs23evZZBhtclOTx4dneDHL24RKilc3KEqSQGeNboRkSg
        4R06C58fWsqVjy5J/7t2O0PhFj2QeHhM4OyrevM=
X-Google-Smtp-Source: ABdhPJxS1+nQ8y66RWllXcFX6CpqmyK7l2EbhZtOSMNl2unbaBg48zmMdW8653aM7TdJTlzeWlKOjkguHOz01SQbn4Y=
X-Received: by 2002:a05:6214:1588:: with SMTP id m8mr4556655qvw.18.1603979549503;
 Thu, 29 Oct 2020 06:52:29 -0700 (PDT)
From:   "Brian O'Keefe" <bokeefe@alum.wpi.edu>
Date:   Thu, 29 Oct 2020 09:52:16 -0400
X-Gmail-Original-Message-ID: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
Message-ID: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
Subject: [PATCH] staging: rtl8723bs: Add 024c:0627 to the list of SDIO device-ids
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [209.85.219.48]
X-ClientProxiedBy: MN2PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:208:a8::29) To CY4PR22MB0392.namprd22.prod.outlook.com
 (2603:10b6:903:b7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qv1-f48.google.com (209.85.219.48) by MN2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:208:a8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 13:52:31 +0000
Received: by mail-qv1-f48.google.com with SMTP id bl9so1328434qvb.10        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 06:52:31 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ffe6b8-958f-42bb-04ea-08d87c11e174
X-MS-TrafficTypeDiagnostic: CY4PR2201MB1126:
X-Microsoft-Antispam-PRVS: <CY4PR2201MB1126D42D87DFB603765DF9AA90140@CY4PR2201MB1126.namprd22.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4LBRwtOWDIpT49AKABSAiCP5eiQ8FsJJztpeSpZSAxucaimnPoPXLHTcswlON62tgC2wSK9p1E0qI3EgEl60SoiYDEF46VyOHkup+bFECAFhl4dAC82ALOAfEvJELDRP0On6Z0V0ReTcqAyCqF8P8fNFu93OtF6YqpsBfPNo0ldkt8F/DWIiixK4Vfo9XXrkrsXAHku3uCjIM/R3qCKW0x9vGtZHZEPs/hoxn8jp/3/3JywF+TbMFt2z5Jf9pvEjIV3FnMGZbZ+Yy2+/5gDNLbhC9gQuswhN8gfzKXyHgPFBeVQR++jkhjYL8PRj7pWxezVSEnPX1neCfqbzGRgvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR22MB0392.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39850400004)(366004)(396003)(136003)(5660300002)(316002)(786003)(478600001)(4326008)(52116002)(55236004)(186003)(26005)(110136005)(4744005)(2906002)(55446002)(42186006)(8676002)(9686003)(86362001)(6666004)(66476007)(66556008)(8936002)(75432002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6xGR/Bzsu6Z0ytgKO7ZwrV8s/db9QOTqJi4WYCSN5O7y+o1Oa9y0bmBS1Z9IHlCEOyJSfSCcNfGW0EJZ/WO/lgxo9I2sUyJFuXrksqjlia3mdiMRFy8aK77oTA09ON38vLBL33QKt5RQIxXcgpLkvXOstVWXd/75HUcAoDG021ttp/ROuC+01n/rjLtLOZ64KgjIZ+7jzKVv69klt9P2HmYcrPBc+NxY9y5KZuVHsJ4c5z6RjUEatekXYjl3lhVLnuVhATFikchvCCsxBAkRtuELsEihgRxPUKwJEuBe/lgJ7KDO60FG1Z77sRjp8ohlNCpQwDggmrW4Pvc6LMrsTqfsVYm5IjQqxaibrrjI8JB1JpLamsdkAiR2q8XBBD03pVchsgu2ibcqrpuLdXqDA0Ec9Q0r78m0blSyo3GpCgbhh9zvETdmTrIRU0nMg/8NbNn5Wgccd2EenaGCvh4kalLy3cv+qfiJmXHfS3AjeJPHnQ0lnhKqX2hXIqrb0ppjuGvTWGyjcOcq6Fn9fD7gtgXedZz0l1uJuCSTJj7sAbnr0YRpXxLR94vwlVtzyksPxeA4AztiV+NFIRn0jv/9fRw0gmS1WFVnoN1w4S8YyHb7Io5ynl4Mfb5X1E8KhKeILeekQ/Pl2m8jFWd4FTq9OA==
X-OriginatorOrg: alum.wpi.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ffe6b8-958f-42bb-04ea-08d87c11e174
X-MS-Exchange-CrossTenant-AuthSource: CY4PR22MB0392.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 13:52:31.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46a737af-4f36-4dda-ae69-041afc96eaef
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyIINGnHUhyWZeQ2OtPt3V6BNjPJ5xxA8pB1FcX0brkl35fmCV5g/IfpSGQCgMaFRLA2O7vOEPGQejqr2YjMuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1126
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 024c:0627 to the list of SDIO device-ids, based on hardware found in
the wild. This hardware exists on at least some Acer SW1-011 tablets.

Signed-off-by: Brian O'Keefe <bokeefe@alum.wpi.edu>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 5b1392deb0a7..7256d55fcc1b 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -21,6 +21,7 @@ static const struct sdio_device_id sdio_ids[] =
        { SDIO_DEVICE(0x024c, 0x0525), },
        { SDIO_DEVICE(0x024c, 0x0623), },
        { SDIO_DEVICE(0x024c, 0x0626), },
+       { SDIO_DEVICE(0x024c, 0x0627), },
        { SDIO_DEVICE(0x024c, 0xb723), },
        { /* end: all zeroes */                         },
 };
--
2.25.1
