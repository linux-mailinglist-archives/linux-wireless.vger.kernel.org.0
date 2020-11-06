Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECDB2A9867
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 16:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgKFPRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 10:17:32 -0500
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:50686
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbgKFPRc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 10:17:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7rvSqZ8ZK87YluJlVWbuWFmJh2od9gf5GCoylYlVSx+jcnQohoioIjpgbzVvMDeTDMKGVokzHDXRiex484Oi41fhwuc+P07Q/IzK+CYcu5/DQdpDPWtHw+JBy0G2sBBwaLiMGcjiILx3y8+fw6P5AnaUr8gmK12ED5rjrH1RT6wFQy//gFXjeiELBhlVyLOhh4yuQEzxTo09Py48F7OBmhg4cWMSRnxyQyPzOPMiuktgjIp2FbVVpD5pXh49UTmUJPUjOrZ49jcJ8oDRasP9uaJfTkyBCpUhRw7a5tWSrxKkOShJLMfKyiULG/EvJaQ9yJ8RIDAYiKEqoON/ef7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCwwz4xhu2F+Idmu2wIfN9VZjj6Yq2b17WDlRCOiF4I=;
 b=OA7k1L39irXl13SWZnKwdc1fl7GYga24dkNiny2k1ZXnIxgRTdRoInjSSeEuAvjMn47QxxtdJ3WpsMkaz0P7sSJFWlo22iomak+tSkA/jfy1U+dX73VGB4yfsngM8pctmxmj4o8OvaGAGhQYjgkEkneV1TL+s2vxmAz8V/B+KPT/shCCSvxMZOUhi08b3tfFw3ebJ5MXPHWQGw3/HCxmRzDevZslGpl6VnVS6k3ospSEh1npFb00P5AoDWDpTCJMldB4i/eHiP4rCDIi57P6zOp6SBItDzLBXqrBgVH8LocOC7pG3+C834PS3DNIvCD3lLxqQpUNjIit1pf8SQHz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alum.wpi.edu; dmarc=pass action=none header.from=alum.wpi.edu;
 dkim=pass header.d=alum.wpi.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.wpi.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCwwz4xhu2F+Idmu2wIfN9VZjj6Yq2b17WDlRCOiF4I=;
 b=HIPvhj55ZuOc2CMi3+StrSWz5JWs4iBYCDRGIJToOenGm+E0Vt8FKb/9wypF6KED4SpJ5pSuR31BcxqGyZuhv5dwuQxd1A44CwELjgZMQzb/4GsPpApTI4ZKGUv7m3th3H1T7qGvrECey2H177UA3SX+Cm4+RniNlOMOkR0wpYs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=alum.wpi.edu;
Received: from CY4PR22MB0392.namprd22.prod.outlook.com (2603:10b6:903:b7::19)
 by CY4PR22MB0454.namprd22.prod.outlook.com (2603:10b6:903:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 15:17:29 +0000
Received: from CY4PR22MB0392.namprd22.prod.outlook.com
 ([fe80::20c0:ced7:76fc:f46d]) by CY4PR22MB0392.namprd22.prod.outlook.com
 ([fe80::20c0:ced7:76fc:f46d%11]) with mapi id 15.20.3541.022; Fri, 6 Nov 2020
 15:17:29 +0000
X-Gm-Message-State: AOAM530ESy7p9pEOXlXhYDrn/BrlEj1Ndvr1vAepi4d/79oug7ROiieU
        EJ0CIosU8UDc+cZlEUS0fY+7mN2BplKOx4ds+Xc=
X-Google-Smtp-Source: ABdhPJyKthLai0TEXe+c0v4ZmXz8BtVj5Cb8Ok4+0YemE6HLJkoYlvKxhVaoc14y3GYzGP6/c4UDKlclTF+QrApgwF4=
X-Received: by 2002:ae9:e709:: with SMTP id m9mr1852580qka.397.1604675435789;
 Fri, 06 Nov 2020 07:10:35 -0800 (PST)
References: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
 <20201106101240.GA2770702@kroah.com>
In-Reply-To: <20201106101240.GA2770702@kroah.com>
From:   "Brian O'Keefe" <bokeefe@alum.wpi.edu>
Date:   Fri, 6 Nov 2020 10:10:24 -0500
X-Gmail-Original-Message-ID: <CABtq2xQJCGvBhU230y41DbOgQ7zeP2tzqoV8WUT5Fe2JJc9hCQ@mail.gmail.com>
Message-ID: <CABtq2xQJCGvBhU230y41DbOgQ7zeP2tzqoV8WUT5Fe2JJc9hCQ@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Add 024c:0627 to the list of SDIO device-ids
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [209.85.160.174]
X-ClientProxiedBy: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To CY4PR22MB0392.namprd22.prod.outlook.com
 (2603:10b6:903:b7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qt1-f174.google.com (209.85.160.174) by BL0PR0102CA0015.prod.exchangelabs.com (2603:10b6:207:18::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 6 Nov 2020 15:17:29 +0000
Received: by mail-qt1-f174.google.com with SMTP id n63so965693qte.4        for <linux-wireless@vger.kernel.org>; Fri, 06 Nov 2020 07:17:29 -0800 (PST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46e0594a-5e60-4b29-231d-08d882671399
X-MS-TrafficTypeDiagnostic: CY4PR22MB0454:
X-Microsoft-Antispam-PRVS: <CY4PR22MB04540147AF723B3BB33B08B290ED0@CY4PR22MB0454.namprd22.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qD+PRYNNThKGYk5qvKBL1Nir9t2J54uRMk/65kCzGi+nAf1Vz9CZM7LvU3Sw/1BHIloG4UWNTno/VucycKeTdymxuWQMv7pQYqO1/seNp/LLVPt5aW83LAUWvK+s1DxFkupg+H1XDgnTf3p+5mL51HttT+c1Ac77amesH3xTay6ISCpBke7iZITZZ71MtcItWl3mnCq9raYHV6dSuVrlvho3WRtI5kkDqZ3zHyISfxl8KHJLT5ae+o63ThzAG7n7YnoHT3rVpVqJmB4nYMJen1gEzpagGCQZndRTfvXfY3/SUz7KQn8GYN0imuxcd1hXVcS4lDlksFxWN/l4ksBW4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR22MB0392.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(366004)(136003)(346002)(54906003)(2906002)(66556008)(4326008)(786003)(42186006)(316002)(52116002)(53546011)(26005)(86362001)(66946007)(66476007)(8676002)(6666004)(5660300002)(8936002)(478600001)(55446002)(55236004)(186003)(75432002)(9686003)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3VMe5jA7j/nLB0vnZpj5EIIeT3g+7W9VxjbGd2MpOIu+S8aD4PCP+NK78v9G32mkyC8JfriED/D5edlgn9uynLa5pv7hQioLoxetUNg6VaGiYcNAmw1JvGNDr9Hol6v6MmjKASob+ppGfQ+k9vaXaPmL7s9aIbEVgZvSoRUhKRtMsQARsU7BDgCQjbrgSNob4O6DmZKBNt3yB5EIrSAgNA3kqVplyrfJZEpG3hjalMjLUG4M+O+k5RlcUWV0MN/RoEeAwckIyvXQUVt8nsfcfWBEOatkEXTxJATxveMb+vCy7icermYwBbfsLYrJ39iHaRgbOex/uHtoryA/73Po2d/sTawZcUSkBc+uEh5t3tWqiOTDViaO12lA01PeaUQxC+rPNnKX6DOdw6EUiNfvQdkfVbuKnUlzrUSnhG3Svn8f45phZ6UjM3EfYlZmh8arONvaO4nkK5hHeu84yyeEd7RKKnffkmROd8j0iK0I9J0qP1Qx46El+Djfijr9qrgUGi73Ee8F8XDS8FgB42bWkTcS2m3i/obfFgo5VU8gRYAHDgXzLI2MmnlWgRmAeq9PX7IRLSwt0YVHDHFuO3dkaLo7ix65OeuUX8o1JQaHutdsw0GwKKTpWQFo8h4LMGbwRzLbqrhLqJFyllxLBWbYKw==
X-OriginatorOrg: alum.wpi.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e0594a-5e60-4b29-231d-08d882671399
X-MS-Exchange-CrossTenant-AuthSource: CY4PR22MB0392.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 15:17:29.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46a737af-4f36-4dda-ae69-041afc96eaef
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WMAOVcfHcM+d5uRUyXXfscUX1OTgMi7DJVOYHlc0ozqidOTBYUuGzDHXOyJuLEjDaHDHkIe9XHFeVVspYF+cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR22MB0454
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 6, 2020 at 5:11 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 29, 2020 at 09:52:16AM -0400, Brian O'Keefe wrote:
> > Add 024c:0627 to the list of SDIO device-ids, based on hardware found in
> > the wild. This hardware exists on at least some Acer SW1-011 tablets.
> >
> > Signed-off-by: Brian O'Keefe <bokeefe@alum.wpi.edu>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > index 5b1392deb0a7..7256d55fcc1b 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > @@ -21,6 +21,7 @@ static const struct sdio_device_id sdio_ids[] =
> >         { SDIO_DEVICE(0x024c, 0x0525), },
> >         { SDIO_DEVICE(0x024c, 0x0623), },
> >         { SDIO_DEVICE(0x024c, 0x0626), },
> > +       { SDIO_DEVICE(0x024c, 0x0627), },
> >         { SDIO_DEVICE(0x024c, 0xb723), },
> >         { /* end: all zeroes */                         },
> >  };
> > --
> > 2.25.1
>
> All of the tabs are gone in your email and it's only spaces, making this
> patch impossible to apply :(
>
> Can you fix up your email client and resend this and keep Hans's
> Reviewed-by on it?
>
> thanks,
>
> greg k-h

Sure thing. Sorry about that; I figured out how to get it to send
properly this time. A corrected patch is on its way.
