Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8134270BDD2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 14:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjEVMZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjEVMZI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 08:25:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::70f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B7E172A
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 05:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dftvHBYzf9ZpbVRo+dOkyXpX6phHcW0b6mppKy5dE+NzzRtuyzkGw43WkrvZolgKd1UEP8bCzHlByMmgpR00GyXiu/yANyXrdKTwvxR6+0Q4AWyc9RZr6jood5YdpKEuMeGdu1uudFxVVGCbeuClJVjmi2hQb37rnC/ZpgDIdtxnqXwRvm4JEFrSmY4jeQfWXyDzHU0yZmPv4IOyFVAHVJcjMuyu9Mn0MFjmj7DoxsK4krEk/86LOdRuxoaLhhna8wbz98kC243lCX0roSVjdsZqveLcIxIutpvITP9/g37BwirjWpr2e6as4avGYGOOL7po8hkX9O5K2l1CR0rUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irSRAMiNtOnoiNWMkPlCxolweeXWmimHTKIQVOGFDdE=;
 b=I5so7rQwblSa48NbP2NJAdbdpvS0zF9laQgDQMvpoCSrArXrBDdRzzY+p0goF8bTvjHNOUWreZ9okAep/U5nk+ngvJR2wWJIyNkpPeDUW6Tb1TQfozUpWPkkOgPSCigJwg7K1snIs2cX/WjUjsksB2dGS1QjHcNCXQm40CaGImqtKUv4OcpBoV7Ho9gUUWSulZa8TepnOFXXZFqETBA5nAl8cOqdnNsTkCya+UgKaB7ErYpDerxxZ4o8BAyvL+2eeypWlkr0wS3n3n1IdthbA1mv0hiKBZxKKIZd/BZljRjgc4vXzTB1j3zkDPRzXqUcqXRgjmZXHF3c9emQiRB1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irSRAMiNtOnoiNWMkPlCxolweeXWmimHTKIQVOGFDdE=;
 b=ZY0EJBmMRS6d/89uA9JOBrfVa9pI7EjzlRLanLIkEwPBHEhacJm1gSudxUlwKYwTtJFod/Tu1BDZlchEd2WB4V0h5N36jtq/p0swx9I7xjoWjrwcH9H2Xi4BuenecDrPAo74zKp+LlpAQDjLk523DoqJJ9Bk/zXI3S7U3x4olLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DS7PR13MB4576.namprd13.prod.outlook.com (2603:10b6:5:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 12:22:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 12:22:24 +0000
Date:   Mon, 22 May 2023 14:22:18 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7996: fix endianness warning in
 mt7996_mac_write_txwi
Message-ID: <ZGteemw+FvK0Kio6@corigine.com>
References: <9509f4bc32d9321f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9509f4bc32d9321f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org>
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DS7PR13MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: d9220a37-5720-4677-1f63-08db5abf32d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RcNDnIaJ+9h56lgDtmocDllsIGfadGOTML7CSRChrPuitgr3nD6h3+0zCwkeQ9Z6Degc1I5ZWsZrb3FCKNmREszNhcplsWhtVXPVtvskKg3kxewGbHZKVEbjFsx+vJ1aJYfT6VErEnri2ycqDkVSSVkbIFlcwyWesCMHCcyyecJqDefK/H3JBGb4MhpllakrXk4CW2ozz8J4T+m7q6GMy0WI695H75fcS4HQi+BqmSqF/nhfkY1tfhNS9mRx/fR4nG97sB88J2CJ7FPgWHrj3n6A+dovReQlPsF1qrvLh+p1BSRvWxe74VGv1lynTr9fj0LEP95aTFNBUZAjmEFz1ex6olA4j8wlXphRgKwbTrjrGyFrUGOf/x0fCzjEF7HxrboshveqlNz3q5uwPGXAB9m7kLnCA+qO2wts0Xjbr4n639lCh5CqFD7v1Qs5R+WSvIzhP+tU7oYmIhCHEh8Zj1k+RrTHM7wr6mU2ENbiCrCtFDoIP/UiRaBTUtDrBX7Hwy6BAIG6n88r+EpYPaG9VUdcqCv/yhmV1pbbIQs2MlklWcwb8mMpl+iXg2FM6GZv4qkHOie31hZ/odlQi5sIipj8/vsLDwdmfqlyk+FKMO7D11iC46gx+lPo5apaIcUNWZNAAHOMofBX48F4IWEr/WkGoRBq35k2KjXsSb3GTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39840400004)(451199021)(478600001)(186003)(41300700001)(5660300002)(6486002)(6666004)(66476007)(316002)(4326008)(6916009)(6506007)(44832011)(6512007)(8676002)(8936002)(4744005)(2906002)(2616005)(83380400001)(66946007)(66556008)(38100700002)(36756003)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Z80QrmxSgAigdecyb2lc0A0YFBk+pVk45nYgCYblWfP6+5tEsV58/3Oegt6?=
 =?us-ascii?Q?unGBbAcGSI5QkWfmpyBR/2qUoz0BLvFNtNc1s6vwAQkaca2T3yYxHYpsyKYJ?=
 =?us-ascii?Q?2L1BSvfI/dvQlcmjV6eJxZ6QFZcAluYPMqkHYFZN3bs9JjXvkAQ6V3IfKU2s?=
 =?us-ascii?Q?ZJ/bwr1IMGiETfJjweW5hQlN5GLpaePEl1jE0DEhb8gnSHjVJZghJFOJXIdb?=
 =?us-ascii?Q?roWCdF76D6IsQkjq2YqIPUWOkZE+ePUMcSfgM2veUKuUmxG5lwRUYi1jXK9l?=
 =?us-ascii?Q?7vWA1+do4lKTQAjzwiAEg7aZvgrTJylwvVW+coMgx/rpm+wQ2n6OEjiKyRd6?=
 =?us-ascii?Q?ZYdxDxd1weeusxdztYm4ieWPcTBtA6ng3qJQNxRilOyoCm7BBUC4+LwMGtjg?=
 =?us-ascii?Q?URHP1B6rDL+A9eCkPLMA4p88mc1+uPX0nQ3dBRbih/knzzN3DU30pwZVMCEs?=
 =?us-ascii?Q?mpGJ/yVgoy25v1/QvDP/pnOdgW+mWcva73BFfq0Lebju4kXfmKnRwrrHB8dc?=
 =?us-ascii?Q?fj934ILNtuQoPD6Nsr/Jh0/sO9aoys59PBFf3af1O0A4TV+Pt6f9SfkA1NNm?=
 =?us-ascii?Q?4ik5Ol/2hIj9Up4TTlpgaynTnikNKyQXjMf22+ZSQCWoKMAct5lD4xcHueiW?=
 =?us-ascii?Q?oVOZrfQBWsQe3dnaLspOuefdPSNKoJmQ/LTs9xqtqYHl6NayuntkM6FGLOXf?=
 =?us-ascii?Q?HguGxTstzbosfXE5AwOivjxjjjbDhIUWgl9QnHwzV4AReQ49zhkpPeH62uF7?=
 =?us-ascii?Q?UuH9dGVdUSwLTI1yNf6ang0dnloM9kykCit4vfSl8p14kmjGE4SZTBhLZ2NZ?=
 =?us-ascii?Q?4D2MDxwhU7LuNdkKsQ0LqXMs0afX/Vo2Z6SwHjmxdH55SF+NLgBkh1jj0lsd?=
 =?us-ascii?Q?3ukCPnnjYEdkuZgSViCnwJubR1UBOFfJIE3Tt2nfds8Ii4BOODQsvFxErZ2f?=
 =?us-ascii?Q?5RSjWQgewIguqAWrreJtqegNCvKfaVwetJzcJwMPIs3Q5sboRe25TCgxE80o?=
 =?us-ascii?Q?bweUw8rdu1lPIzhDMS2RgIjxecP7fWSIXGb1Vlz9zFKPYc/enBmWTD2lkq5q?=
 =?us-ascii?Q?sdA4adm7ILGf4ZvPWwnKhTIY41W0ZmAp0JGm4bvKIj3cgMsItp6N/9mvZYFJ?=
 =?us-ascii?Q?tOD1jYj/5HWmrR4oDCCI14L4JvMRFD1+5EUTpQcKrPZixtxhD5Ay2Mgwi2Lo?=
 =?us-ascii?Q?zRMCHK0AcVggD3QMXV0Rhsovdfeo5BDl7auFLeIo7vH162z193PDOUYS75JG?=
 =?us-ascii?Q?kgZ1RYWly7WpDIKSFtcLgHJUPo0VD7jPBStf7e/8lTybpgLoFA0jb4mBOiUh?=
 =?us-ascii?Q?2BOC7vC4XJCA5wefd8c5iWk2rZyqZUnUfkP+MxUMH9/rmBEXEhPHo5/gkLiN?=
 =?us-ascii?Q?/qxlUvAMmw615YINVP+fevceJpdxnBBmepwaE5HiSzf+V72pGBD2hv5CwcUx?=
 =?us-ascii?Q?H04OsloyibBghgE9zU6q6FnYbqBJuU+533UiFbY+BZ42KeiApcgFSnlNX6id?=
 =?us-ascii?Q?1rbKw7gLfuArGXhFBU6Ie+aSSpEw8RpuDeBxbcew6pgDZGhY0R20Zkr6fHOp?=
 =?us-ascii?Q?D0Omx7HHuEy+FJCxkRuIUkAJ+awc2rDRH3OBs3wWXgARApSIm728NQ5Tqclh?=
 =?us-ascii?Q?3y1k8SefwVBr8YWmDuGvnLaTl4dw/iDyoaPcoYOKTTHGajK+se43CYgdHx+R?=
 =?us-ascii?Q?QsqoTw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9220a37-5720-4677-1f63-08db5abf32d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 12:22:24.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLd4vZZcpiKz7y6/ph0d4wEBeFNOVks0RjrQ5+6zLi8vRkwCL5GmvmkUgMUrl0AR7CFhnIQqFlJZgzJ2OB88DdhJY9tMvcFwob0QLdWnL+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4576
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 22, 2023 at 11:09:01AM +0200, Lorenzo Bianconi wrote:
> Fix the following endianness warning in mt7996_mac_write_txwi routine:

FWIIW, I think this fixes a bug on big endian hosts.
Which might be a better description.
But I don't feel strongly about this.

> 
> drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25: warning: invalid assignment: |=
> drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    left side has type restricted __le32
> drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    right side has type unsigned long
> 
> Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
