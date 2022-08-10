Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431B58E9FF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Aug 2022 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiHJJpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Aug 2022 05:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiHJJpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Aug 2022 05:45:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888118F
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 02:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpJMOorNg8esCmDMsxqERjZAGeU1UcfeIsxBtiTb7fvYRP+N/EhgH10GHx4f3OGlaH+cW+Ac4V+ayrYJTDWXmbWPZvKCgKiwL7lqxMAKWi1mzD69AezfZ+qL511+utDyyT+HFOqPiPySfiWdL/C9tjr7AzRiJt96TwUDpNW2XUy7CmdX0PDegXjh9VI+/GDdbJVVCpEnkdpQkJcUHfOeNeyY+SoK/820UQqTmfxIY/IHWLLHPK+SA80zNxlcXU8LEAbhzbqjH/+ulIeu6QZWNuGmUqBOy51jiqCh+6E26LIUXCFeV9TvEEsJMl8Qb86OSX++5L292iYFR1cjUZm5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5A62lxH8yFs8gAfbOMGGUK/+B8dCAKicneGS0E7yck=;
 b=GR5rH5pbq2T+utArE8U26aTuYw4cdLjc4I1yHry95ugW8JLZqJ5CKXwOo/6dQzpCRZGlMGafHMuC5i0ck5JPhmq9HgNtCEXE9y3R4Eb3y3HSL/ryEUdFwRwphwuwrBrQ2xwDsfvACw8B166f/9uZv2np1RWriCIwPQa8xbdBZ0eTDdCZQfi5t4YQ2owx1hNf6CNQ788JQKCzUMyd1+mGkTddl8zDy0SkAEvAQfosE9ahrZBDMaHTSmrkuEOd5DVChNJm3mwWLQy3xBAgWVr4jykCs5OUl4ILIkc74e/w3Oem3badom6qgzN86CFc+A3fWC4BAwoknPCn+/otLa0/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.136.252.176) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=stryker.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=stryker.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stryker.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5A62lxH8yFs8gAfbOMGGUK/+B8dCAKicneGS0E7yck=;
 b=fAzm0XgnYF4Eq9POiqRedHxXQrczfIhXkQfnfO6OK5aZf31jGhlWVMbt2hB4zCWNqmjEqBwDPV3hliXFeLl6uswHLYtf29KK/VF/EBItBa34YU6lG/A0FBd6+0GQGGAScc1Toqh3o93KTspdwi0py1u4kLDEVWA82rblVLqLAkGw5eJKWCx4XyJP7rNXon3TKuVQMFNy7tSSklYpnGiOjnQtOzP5p6GXDr4s0b0C23LRt+YY+URVwX1hA2J9MqguRA0s9/ItyjZsfJ623+cHQQWI5adXUFnI2sFkr8kB0RhiW5Zn12+kugl6F+xlX1NxEKuv9VbWEn314jlfxqiLBA==
Received: from BN1PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:e1::27)
 by BN8PR01MB5556.prod.exchangelabs.com (2603:10b6:408:bb::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Wed, 10 Aug 2022 09:45:39 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::58) by BN1PR12CA0022.outlook.office365.com
 (2603:10b6:408:e1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Wed, 10 Aug 2022 09:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.136.252.176)
 smtp.mailfrom=stryker.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=stryker.com;
Received-SPF: Pass (protection.outlook.com: domain of stryker.com designates
 64.136.252.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.136.252.176; helo=kzoex10b.strykercorp.com; pr=C
Received: from kzoex10b.strykercorp.com (64.136.252.176) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 09:45:38 +0000
Received: from bldsmtp01.strykercorp.com (10.50.110.114) by
 kzoex10b.strykercorp.com (10.60.0.53) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Aug 2022 05:45:28 -0400
Received: from bldwoapp11 ([192.168.131.10]) by bldsmtp01.strykercorp.com with
 Microsoft SMTPSVC(8.5.9600.16384);      Wed, 10 Aug 2022 03:45:24 -0600
MIME-Version: 1.0
From:   <noreply@stryker.com>
To:     <wos@stryker.com>
CC:     <linux-wireless@vger.kernel.org>
Date:   Wed, 10 Aug 2022 17:45:24 +0800
Subject: Kryptowahrung macht Sie zum Milliardar
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <BLDSMTP01kU9X3melfS00149bae@bldsmtp01.strykercorp.com>
X-OriginalArrivalTime: 10 Aug 2022 09:45:24.0303 (UTC) FILETIME=[E9FE4DF0:01D8AC9D]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f87228e-e713-45dc-db28-08da7ab51533
X-MS-TrafficTypeDiagnostic: BN8PR01MB5556:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6j9fROs0lGTNtraXxXDrw13TN1PpY/B8SkM5k7/tPWIi27RrjgQBKm4ChFgou4m5Z+HQ5QMb3g2XUMrur8gMunPSh7N2BNFP1OquSEJbGDAzG2nOnJNGVvDwyIfp+ZPOYN6zULlZZnZS3wkNKnI5S9l/BwQqbhcJvav4SCqUNv66Nni2rgmvnItZr+KyaTpqTZQprEgGkHS1fNmM91QeKK4MM+G0XciKBCb2yfUzK/ZR+phUOGVKHsrGw+PteEKziox1Cebr9OOujq0B20VogB0+she/tUpGh9cIIsVnGJlMrMC7dqAEvgLHKOuFPtqeTAG0sSWPWbFwEMpyjp+q/FZTsTCMGTifIuzI/lbuZM4Cs5bMCuglR7WcN1xJhlDIeANWXMrKLyIaNtX5hTjyRAtzTy3X3hvVhAAyyLGQCFlXsLfX0o6IuTDX63R8ervmJujABDDh2xegWu3OrLnkI+vmp32sWYcw1usnyeKMNifrz6Luzjr2F1Ye3UuESLuOqmJYBmSl7Nz1kAzYodmnTnd08e3LPrZKjza9nt3Hdfbf5mdtMXF3p6dd+1XR/XBe/xDPvBJ2jnbYFgr+VppIB5BP60aEGITUow86ICd6j1dhE7mwAfmV0fkDtYIV8NzYZ9r4sSDFyqOKPA3y7awPBl9b0wGftllpyL0TK8ijJJzKhBusgAfwEe/1ZWDiMPCgIle9quqMiAdrXXparnViFvqwWxA6EIYupG4hqmAVhGBOkvHhPmp20pL8YQQDl1Z1HwxveC5pr7wLJVwMUaHEdfUjSlE4vCeWHO6j+ozB4sJQEbzRfhP7E7QLl6MCW2+5
X-Forefront-Antispam-Report: CIP:64.136.252.176;CTRY:US;LANG:de;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:kzoex10b.strykercorp.com;PTR:ip176-252-136-64.static.ctstelecom.net;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(40470700004)(36840700001)(9686003)(8676002)(186003)(336012)(40480700001)(47076005)(26005)(4326008)(966005)(316002)(70206006)(70586007)(478600001)(2876002)(2906002)(41300700001)(356005)(81166007)(82740400003)(40460700003)(86362001)(82310400005)(36860700001)(558084003)(8936002)(6862004)(6636002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: stryker.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 09:45:38.7860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f87228e-e713-45dc-db28-08da7ab51533
X-MS-Exchange-CrossTenant-Id: 4e9dbbfb-394a-4583-8810-53f81f819e3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4e9dbbfb-394a-4583-8810-53f81f819e3b;Ip=[64.136.252.176];Helo=[kzoex10b.strykercorp.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5556
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RElFIFdFTFRGSU5BTlpLUklTRSBLQU5OIFNJRSBaVU0gTUlMTElPTkFSIE1BQ0hFTiEgaHR0cHM6
Ly90ZWxlZ3JhLnBoL1Bhc3NpdmVzLUVpbmtvbW1lbi11bmQtNzUwMDAwMC1FdXJvLWF1Zi1Lcnlw
dG930JPCpGhydW5nLTI4MjUxNS0wOC0wOQ0KRm9sbG93IHRoaXMgbGluayB0byByZWFkIG91ciBQ
cml2YWN5IFN0YXRlbWVudDxodHRwczovL3d3dy5zdHJ5a2VyLmNvbS9jb250ZW50L3N0cnlrZXIv
Z2IvZW4vbGVnYWwvZ2xvYmFsLXBvbGljeS1zdGF0ZW1lbnQuaHRtbC8+DQo=
