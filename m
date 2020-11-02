Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD882A2DAB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 16:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKBPJH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 10:09:07 -0500
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:26464
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgKBPJH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 10:09:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfFD6R/V8+kG1MYQZLeZdfTHW470oX+VteVOrND19iI36jTQlVSNdrAlMgSU8uB4bRDGScfeJynV1YMoZpPsNapMtrBucc8NO1u3NVAYnQHkAqrra+wRjVKdHMGof2YrdiQJDO6y9NQnKorNC/AyifLsZxQuRsFpo2mmTnkrXTopbW5T/+lAAz/Jdl8q0KedLTNM7sxImXjwkoTAW5SVkHs32pQTYgUvaqws3RPDix7zkpmozrn2AYOSVO0p3l5YoG8B+AVSmzqdrfqyT+gfd2Cl6D2RWNkYob2CzVzBZyF9uGTZAmPCrsuky/CgxQt2r0KvArbNYB+5cyt+jWUi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okrkGbdZCEFX5XefclZID0YZYTVdkssfilr7F/W8BJI=;
 b=nJaEZgBlI0Nt1imQldnFhB40T+kZOuWK71KtyKHJWnjy1QpOHU0c7xKxcM2DGy4d0WmLaQHXNCWz8PD8RkWx0T3P54RK25emYeUOX2on0WYucj8zuH6qy987oJFYNE91eZLGBxLmQF4S+F5nHDM6UPdA59O2xfwQPwHt+J+sKUoUGvo6h7d0llNxiBEA/J0NhXaY7k/VzMDnhrmsba65fXV0SWQsxFFN6L2KFPNk6IsYaK27/hsS7xL7tmUL/0/9Yu/IXdCY3sMma3bycY1ErorTE/S7hxXbfeeoBRBgNkbwMO1kf3zifqQxFcCufp5YMMbrnBEcve1JVAWBpW/JpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alum.wpi.edu; dmarc=pass action=none header.from=alum.wpi.edu;
 dkim=pass header.d=alum.wpi.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.wpi.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okrkGbdZCEFX5XefclZID0YZYTVdkssfilr7F/W8BJI=;
 b=HCwpCJmoJ+HAq2XKinQAxgUT/V+lIwF6SGl0b1ThxiAKfasilQOAUz1S62wL1sIEOwbzalGAS0PS7mSs3/p8hGjjWOdjJhU3kRk9w/jD85Q+6RjGUXAK9onEh48Z4Bk4uquUzNwHDnQzlDfiopBB66ARy+KrROblRX+47HqN4v4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=alum.wpi.edu;
Received: from CY4PR22MB0392.namprd22.prod.outlook.com (2603:10b6:903:b7::19)
 by CY4PR2201MB1637.namprd22.prod.outlook.com (2603:10b6:910:40::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 15:09:05 +0000
Received: from CY4PR22MB0392.namprd22.prod.outlook.com
 ([fe80::20c0:ced7:76fc:f46d]) by CY4PR22MB0392.namprd22.prod.outlook.com
 ([fe80::20c0:ced7:76fc:f46d%11]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 15:09:04 +0000
X-Gm-Message-State: AOAM532/txQKIzxccZ3IR+r2J6D0gos+o1z9stFraejXkPgenRajvIy6
        opo0ohfn8JEIjn1p0XMwC5jZiR8oQmrJfW5UWu8=
X-Google-Smtp-Source: ABdhPJxVnoRCQ//GYM7kAheakS7wIgAk8o/jLqajnsdIYC4u5RWusrb8mAoHL5+fzjzqXc9KItlzf57sT5sxKT2FAVs=
X-Received: by 2002:a37:8d45:: with SMTP id p66mr14345126qkd.461.1604329741330;
 Mon, 02 Nov 2020 07:09:01 -0800 (PST)
References: <CABtq2xReyqg1wJM7W1d=KWRNTNN0Q6HCgJMWcQ6DH=SmKcxQRg@mail.gmail.com>
 <b0fd8b5a-66f3-871c-fe37-939d814f3f99@broadcom.com>
In-Reply-To: <b0fd8b5a-66f3-871c-fe37-939d814f3f99@broadcom.com>
From:   "Brian O'Keefe" <bokeefe@alum.wpi.edu>
Date:   Mon, 2 Nov 2020 10:08:49 -0500
X-Gmail-Original-Message-ID: <CABtq2xSwcMKbZHYe_yCMMFiQM9UhRRvbCtNL7YVxo0n6GtadyA@mail.gmail.com>
Message-ID: <CABtq2xSwcMKbZHYe_yCMMFiQM9UhRRvbCtNL7YVxo0n6GtadyA@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Add 024c:0627 to the list of SDIO device-ids
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [209.85.222.181]
X-ClientProxiedBy: BL0PR02CA0075.namprd02.prod.outlook.com
 (2603:10b6:208:51::16) To CY4PR22MB0392.namprd22.prod.outlook.com
 (2603:10b6:903:b7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qk1-f181.google.com (209.85.222.181) by BL0PR02CA0075.namprd02.prod.outlook.com (2603:10b6:208:51::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 15:09:03 +0000
Received: by mail-qk1-f181.google.com with SMTP id o205so4911124qke.10        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 07:09:03 -0800 (PST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b3c8bc0-b4a0-403d-4c0a-08d87f413c2e
X-MS-TrafficTypeDiagnostic: CY4PR2201MB1637:
X-Microsoft-Antispam-PRVS: <CY4PR2201MB16374C18A23B102984EF46A590100@CY4PR2201MB1637.namprd22.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T09KR6khXVzhXLgeX7qwY3wxVdTCUbP/ijB0K/r3o6XdT4SljnunhiVhjptwB5GKCrM5jnzPyRvx7rgYv7ASnFr42oIvTrWe0Ndi1CSy7Y3unAXWZFo1v5u4L0PH4w+UlJ/ve5tFnc6efYTtVyvJlyPJpErl63dvUH/5QscCHOZWQerQstzxwak85CZdAs4Z6csSkJ1tUfMkwxvjkrfmJN2LpSV0OjfN9o/ew/NwJGiUp0PqQmEGqR/q2823JjUzBHPEnNEYkt63iT7F6z3TJ3rS0pILx3oi3Jjqs+RMKwaUw8iscvtqu8YAVoQo2ORv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR22MB0392.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39850400004)(136003)(366004)(52116002)(55446002)(75432002)(6666004)(4326008)(6862004)(2906002)(86362001)(9686003)(786003)(5660300002)(8936002)(54906003)(53546011)(316002)(66946007)(66476007)(66556008)(42186006)(26005)(186003)(478600001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: g/FRj0C3hZg4LHCyAX7Z/Gt+XP8OSkgDtAJ+6t1eKWCx/jjMuwcGSUeLBMQfPH/WyL2htHExE+oeSr6qmMBiXJnPCnjX9+2PcZsb5sYdqOXlmWH93GHmrMQPHbPl6NuzKZ6TlVROqYrhTQkt8UNnimXhV9NbBTxAyc3s3K3Fupeeqk8dQoRpJOMLFXZQ+LaaFb9zDdqICrnhJsB86XNox9Pkpt++jMTkIGjq1h/Uyl0TvuEQN4Hb3b9aCT1EgOZxEV0ETQCn6LeKEfTciqVnxfi5u8hHLl5qRdPxj+WDvnKj1/XHhjJ62n1m7+PE5dFfPiK1Y8QYwmcG0SUmjFwZ8uNCI7htw9K/NsgTcXcmI5ZqVexUNlzOcYjjB9CPfh+wYXFQedVYaGHwoWgAJ4bzRZJlIPdT9y919Eje5Bwh+2AqfX04+1p8fhqzA84FMOx60DE1SRDYfq33V6uMoGQDyDeMpwKBYoZru55CQC0dkUD/qMoI0XR6hZVw0mnhRYZPyjwsU0vPQ8oqD0jApFZHV9ImOodYSJg2zaBipOY+8IlWiLEX7QS24wemSvmXSTgy6Mq7QYbdxLG5/o54P4Hos+tUhHLxT2qCzEo8UjJiJByDzCq9kd6MSYPDMGdRXi+rDu+9ZexudgaPlHEnpoXqPg==
X-OriginatorOrg: alum.wpi.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3c8bc0-b4a0-403d-4c0a-08d87f413c2e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR22MB0392.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 15:09:04.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46a737af-4f36-4dda-ae69-041afc96eaef
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o2qaE4VXWqrejgqYQpF+MXv1Li2vuKcGIhKJ7KR30Q8PwjRSsbyv9ywi/hnUdugjSUF7ExyoPICs69XeSXGrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1637
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 30, 2020 at 10:25 AM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 10/29/2020 2:52 PM, Brian O'Keefe wrote:
> > Add 024c:0627 to the list of SDIO device-ids, based on hardware found in
> > the wild. This hardware exists on at least some Acer SW1-011 tablets.
> >
> > Signed-off-by: Brian O'Keefe <bokeefe@alum.wpi.edu>
> > ---
> >   drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > index 5b1392deb0a7..7256d55fcc1b 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > @@ -21,6 +21,7 @@ static const struct sdio_device_id sdio_ids[] =
> >          { SDIO_DEVICE(0x024c, 0x0525), },
> >          { SDIO_DEVICE(0x024c, 0x0623), },
> >          { SDIO_DEVICE(0x024c, 0x0626), },
> > +       { SDIO_DEVICE(0x024c, 0x0627), },
> >          { SDIO_DEVICE(0x024c, 0xb723), },
>
> shouldn't these be listed in include/linux/mmc/sdio_ids.h ?

It certainly looks that way; this was the only place that used hex
values in the SDIO_DEVICE macro directly. I'm happy to submit a
follow-up patch to create constants in sdio_ids.h and use those
instead.

>
> Regards,
> Arend
