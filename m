Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D911E233479
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG3Oba (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:31:30 -0400
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:5571
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729356AbgG3Ob2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:31:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir97YG4nQRINNgL0jo1UnRynfqfTV92MRRLk+eftGLO+4slSpW8kDJWw/NLwuGCld+vWTfcYdG/zfG5g8MxeQWyq8+CCOnlzwhXc/qHmvtCzNSV1qFIA/RtgZAmAI8aWEwSAx2QBzSgw21N/aHqM8vwTveKtak+yN5u0QK25Ac5a7jfA5intR9jX4itLsuCRwIrVtPIUtbsWcGRe258xGjCLQAfUTlnfGng9atcgKmnnLmFVZNUZkB9wMaCoTcqxeWffGwmD+SxX6RM6dllt9n0r0QnZO4p6YzXwhSBpZyx3mNFhB0c6yUYEp2E97sXn+ygAxQ9HtHkUl+eDIo4uBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LNP2xJVyfAvofW8jU2SB7S1/GFEe4zzyJpQ0sfATwA=;
 b=Nipwo7JpMwknAMgaT0/EGdgXO4UhpI57a6xfcg75Mq1l4kcjUCgI7XrQsv1EUH7GRc7Za4yYRhLoZqDrdfo3mliH0zlmtin/mpCDFJjiK8hmVRIwvmYy6lV/GBAatuboMNc6w2aLOIJUOnxjLQpCkIYfQLHR2igEfnyJpko0REwmpn9QYMKGoO7cxypb9/LRg5kD6gv66GhS+0rEnE84WZ92g+G0Gj6eCmvW3LmcaRq3/qc5nSve9S27pzb98HFb1OWgdWXvDq14Gsrh0ej3pkfXu83I4BJ0EP2fvQvdw7F9p/tyrtMFx0pLvCysVTxtrwluSLsB/D/bDBusHjt0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=alum.mit.edu;
 dmarc=bestguesspass action=none header.from=alum.mit.edu; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LNP2xJVyfAvofW8jU2SB7S1/GFEe4zzyJpQ0sfATwA=;
 b=B2Sgm2BjKXNH6dMhZWh9Sy0FbzdanJMYrPJFQ0jBIwppBwTWtFLmlMPQpg5UhDcbv4XljT6+1kKl/NASWpKbTeP94WIL1J1mcNs5MIu4hRA/84xJtHGCacMLkdfIinu1/Y4kVZzLzsC+TLjXlUt6s6fV6IaQkOfiRIN9oeS04DQ=
Received: from BL0PR02CA0085.namprd02.prod.outlook.com (2603:10b6:208:51::26)
 by MWHPR12MB1343.namprd12.prod.outlook.com (2603:10b6:300:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 14:31:26 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::1e) by BL0PR02CA0085.outlook.office365.com
 (2603:10b6:208:51::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Thu, 30 Jul 2020 14:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu;
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 14:31:25 +0000
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (authenticated bits=0)
        (User authenticated as zac.dydek@alum.mit.edu@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 06UEVN0S012134
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 10:31:24 -0400
Received: by mail-ot1-f41.google.com with SMTP id q9so4547090oth.5
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:31:24 -0700 (PDT)
X-Gm-Message-State: AOAM531m/xB/5c13z/BYGoqWdiJ+nSOy+rq8pKSHIzXNmGgJtazoGX5P
        d0MRgkB2ZUf2qGJx1ZGX4BOx/lbWh/Yqkf8m2yc=
X-Google-Smtp-Source: ABdhPJzpTjwExWgEiyHs4RY1mdDcOQFyE7sFURtOo63cQIvLWpEdlPaWK9D69Lu68VbNUDP3ZZWNhK+JrQhuNYQP9HI=
X-Received: by 2002:a05:6830:130f:: with SMTP id p15mr2535953otq.33.1596119483419;
 Thu, 30 Jul 2020 07:31:23 -0700 (PDT)
MIME-Version: 1.0
From:   Zac Dydek <zac.dydek@alum.mit.edu>
Date:   Thu, 30 Jul 2020 10:31:12 -0400
X-Gmail-Original-Message-ID: <CALUoyiA=c_wEFUPbXW=PT4EVnE6SH2vT=a2nkmL2hFa0RUJegA@mail.gmail.com>
Message-ID: <CALUoyiA=c_wEFUPbXW=PT4EVnE6SH2vT=a2nkmL2hFa0RUJegA@mail.gmail.com>
Subject: Looking for a wireless contractor/consultant
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ffdff9c-d7d7-4ddd-34f1-08d834953d42
X-MS-TrafficTypeDiagnostic: MWHPR12MB1343:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1343637194D927D66CDCAECBCA710@MWHPR12MB1343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5H4dCyz+oy1H0R3CTQOCNSM2e8nje4Hh1yR+GBCwK5t2yA0yT6EOjWMCDHHodkkRB/xCHzMH2DCsdNR0EPdPI0WCzGCLeoExkzySc4lRiPkbszbL4p/lQ/fTNo/OF9ObMbBabhma2QeQ0tgnAWoqdqj+kVTIB6R8iDELXu8olbnGxUbvu1MXqCw8Jg2HpvuBmizKGJXQrZ9BTCZQbJ3B6x3CMOvdwyM+0kCgsG658YWcKvicBlDObZ8771a2faF4jt02msnTOtqwDcdiCoppi6dXKnSclGuROpNohgHMFCiPUgyqWtczo6IG/wHhlQvX0M+YIk6l1PYc0HCidHz5kRxIS7gTyyDF3UREELgn1KWO2Nh8GrZmZb0TsAaRkO+Hr9VmF96qVUkQQn8mpznBKg==
X-Forefront-Antispam-Report: CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(39860400002)(396003)(46966005)(478600001)(9686003)(86362001)(4744005)(75432002)(82740400003)(26005)(336012)(6666004)(6916009)(44832011)(186003)(7596003)(70206006)(70586007)(356005)(42186006)(82310400002)(786003)(316002)(5660300002)(83380400001)(55446002)(47076004)(8676002)(8936002)(2906002)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 14:31:25.4196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffdff9c-d7d7-4ddd-34f1-08d834953d42
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1343
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all--

My company builds autonomous mobile robots (AMRs) that run Linux and
connect wirelessly to a facility network using an Atheros wireless
card and the atk9k driver.  We've also used an Intel card and iwlwifi
in the past.  We are looking to improve the performance of our
wireless connectivity and want to bring in someone with deep
experience in this area to review our approach and provide guidance on
where improvements might be made

Ideally, this contractor would have not only deep understanding of
Linux wireless firmware setup and configuration, but also hardware
design (antenna selection and placement, etc.).  Experience with
mobile device wireless, especially roaming across access points would
be useful as well.

If there's anyone on this mailing list or in your networks that might
fit this description, please reach out as soon as possible.

Best,

-Zac
