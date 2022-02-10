Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EBC4B04C9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 06:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiBJFPU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 00:15:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiBJFPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 00:15:18 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 21:15:20 PST
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E98290
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 21:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644470120; x=1645074920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MJJC318AQU8BXPRKIty3K0T5whmoNg+GF19PPMGX57Y=;
  b=rfkryUDm15kcqX2wjQWvEjadJn59z+nE8L+7e5t613i0hAT0p4RYHyr9
   heBQmNmGYzN9qFJvIwmtzVzm4EU1CxK+03zAUfnn9mFFuXw/hi4sOEZPb
   wnkwph04Pv5kgQKTN3YdEUjfbFr9QucMy1Kz9+CEaPz2JjT3qWoj66UFm
   Y=;
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:14:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXpAml6M/vKu8M6dGjdKkcIEHYQ+/0GpxeTGCMMJkss6vzGAh4EAT5vYUIybbFKp5hWgttI6FMNHEZRcAbZUij02ulfb+LLaVnPTPAUQQ16qQLZwb7YQx1O4XtljwhlLtO9HSH466feviRx26NeHwrEpRvWsd9qcHIulGxRDr5dJENS2dTrloqUpqgQkPjH9r1wl6TaGDkb5ggbeBeQ9dfwae8jEvUkv7y8HDTV759GQwvj8AZwQihwmfQJ9YQfcNLrCD/gu5Ju6WoHX8eKNW0gBY70H/ffpdG3h1/I3x5cxpVv+ynz5csGrSjiAoQt2PLddwzmM5ga0ZlMTTh9UOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJJC318AQU8BXPRKIty3K0T5whmoNg+GF19PPMGX57Y=;
 b=mtKcYDqXz2dnAnTZjNHSCtAgIfqG5LpN/10DQY9orMCMfq0sriaKsJOxJv8mUzHxikqGet+d58Jk1eHfbRsWPrEuzAhqeHm+XbnQIwtE/f6wZvjkU9oKf6rlz1clzFlbBu9GyqiVDW5iYQTLM3GQMwyvEOIh7wcBDW79yTMFpyBgrNio/+Xh6zlmawp6KUz+RSzVk9KfgjFr5zP4oKIFwK4x/mX6YtbPqVix/g+NkPvJRyA7lsfRUAOI9QwrSIXwexCNVxVbfG7Qi+8b/KCzoTu3BmILowvya+e3+Z6vP4ZjhkB873W0wapmqgBHe4qKn0qk+Ac99eaWZiCI0L4z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM8PR02MB7958.namprd02.prod.outlook.com (2603:10b6:8:13::19) by
 BYAPR02MB3989.namprd02.prod.outlook.com (2603:10b6:a02:f1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Thu, 10 Feb 2022 05:14:13 +0000
Received: from DM8PR02MB7958.namprd02.prod.outlook.com
 ([fe80::3419:bf67:4f7d:7ab9]) by DM8PR02MB7958.namprd02.prod.outlook.com
 ([fe80::3419:bf67:4f7d:7ab9%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 05:14:12 +0000
From:   "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Vikram Kandukuri (QUIC)" <quic_vikram@quicinc.com>,
        "Aloka Dixit (QUIC)" <quic_alokad@quicinc.com>,
        "Jia Ding (QUIC)" <quic_jiad@quicinc.com>,
        "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>,
        "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "Veerendranath Jakkam (QUIC)" <quic_vjakkam@quicinc.com>,
        Aloka Dixit <alokad@qti.qualcomm.com>
Subject: RE: [PATCH 2/6] nl80211: add support to advertise driver's EHT
 capabilities
Thread-Topic: [PATCH 2/6] nl80211: add support to advertise driver's EHT
 capabilities
Thread-Index: AQHX9xMZbu2tD2Lr8EyrjmTcX6eyyqyMi5ag
Date:   Thu, 10 Feb 2022 05:14:12 +0000
Message-ID: <DM8PR02MB795853BB4B1C71B20857D2D3FE2F9@DM8PR02MB7958.namprd02.prod.outlook.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
 <1640163883-12696-3-git-send-email-quic_vjakkam@quicinc.com>
In-Reply-To: <1640163883-12696-3-git-send-email-quic_vjakkam@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ec43a19-ee37-422f-a991-08d9ec542d28
x-ms-traffictypediagnostic: BYAPR02MB3989:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB398907B5B3896FCB1E0BDF8D822F9@BYAPR02MB3989.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5x0Hrvgotzl/l4mivasFZoeCfeqWkx8JYfl7bK2QKhr+fKt9eG+0a23Kw7IGVNqgWIWdY1sgwuBxLv9NoDyFii5lkqllh/ue3rutHKxyzQCiXu5YdnME93C6Sa722Miim1kZ1UO7fmUzcHM5Lc5MJAxrW+frd8nwjt6GMmRr3kShtKdxk6cnMYZNm8ZrQw6624y70igTthuF9Q26cZZq7dnOFKAHujnsNEDUoigEUF3bEz6+I3WxdhDuAJyh5rahgRKOHOJ1J8Sj3eKszrXr16cwmavGNZtvllMqYpIejwX+c6cRt2uDSoGY/jzh+NhsJ4+UVVKaPwzbkP3Zr3YLYKYIoadfxRULCBUuj5seHBsEKzTzj+5HKfEj7BrBDyo4t5VTgkn9wxqFkORETjLP7VdoxC8JwWiZIbl2LNgm3SsDPPwRDYuqdQpCZ1s6Ttgg20WeiVBqS0LOzUVcVD31CslDc26n0S3Z4AZGVqRwFzVi2DBBOvDj7ic+2lJ3syfctbo6Ud4EGFeNynX/fTU6IWZj9gNf+6lL3OQ01Bp90OFzPNAtsjxpJfqo2iqGuNHiR7iYEkvMPfpGezCmeqHN+OnEgOig0eDc4mg0vQized9lMd0X77HdY2nm0mNkAgiJkJGS4FOluWCM97CGhmtMfpLGkAmePA95EWm/JEoDmu9cQCBiYVKcEddfz4HMQePLQGH58/CeVqVdVwfs2B0ynWyyuc6fH2Bq2N8P+dqXFITYOwPFkvelE/HyCZTe60CqdApR25UKiN2ossuzpbdqK/+JkbMJEjFXQaEev6RBgm8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB7958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4744005)(966005)(122000001)(64756008)(186003)(5660300002)(86362001)(66446008)(26005)(107886003)(66476007)(76116006)(52536014)(33656002)(71200400001)(66946007)(38070700005)(6916009)(316002)(7696005)(4326008)(8936002)(54906003)(508600001)(55016003)(6506007)(8676002)(2906002)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DIaAzcGdjMO6r00rVTefpplRRTFPcRsMMpZEm7rUZzz++ChQQVszH5+Fcm6j?=
 =?us-ascii?Q?RNSwTlwA2ZuOVHiWeCrUp2LU50VIWA3zMNdmK+Y1sNw34tZx91cZPRlGFXqr?=
 =?us-ascii?Q?a62WBMJaKfkFl5jWC4MEXbTqAAtTv2O3eu+2QG4aJa9R5FtVkptp7JEz75G+?=
 =?us-ascii?Q?vuAkwETU7QwFfAoFysTUG84rBIrRWdGeeYCXCHvjCjuewrbC4W5laDVWFGKg?=
 =?us-ascii?Q?R8jdIv4ne9WWk26kIZdm0K6oFBj5poV4jrfMVP0KIlqVoakLGtyQUfmQj+w9?=
 =?us-ascii?Q?0o0srEVf9b/cMgckoAMcyuUCcuLdSXVZnUGNLWjU9aLs//btZwe2vDrixgZZ?=
 =?us-ascii?Q?EdwdSVhryjpVdWYYfNkJC+MP8myFnQah7YFsWZvTbmnRneuagzQmng3Sl+Sm?=
 =?us-ascii?Q?//stW8YKG/QrUN/G7A1ZbvEXggmGdBqlbqESGwy0rtu/yJ7wxffETT7sCME6?=
 =?us-ascii?Q?flk/MGnJeBy+M78kNZS/wHm7MfiLk6jS6evNN7NJtVq7TVLz/Ad8PxwwSbFF?=
 =?us-ascii?Q?mceKOJfYKz08MojvBETWjKTneNUQcl7ISoPw5vNb27Xoi3Vn2E4nbJkgV6Jt?=
 =?us-ascii?Q?bRkuYLA43/4uk9rp9i4uT7NJ0DMYUuE7y3vRWcUieqNg1b6MfMSTxVAIjmfh?=
 =?us-ascii?Q?GKqT9SRcaxFP2P5o8TTF9fWfMPFBE+Zgvp4Errk4sdLeeMaCqD8nnVRZ23uZ?=
 =?us-ascii?Q?Hq+wk+DjV5xpmZb0H7cKWLvqjvXWV0bYoM34e4mYjrDhtDxrERa91FE7AFzF?=
 =?us-ascii?Q?ssWJLwEQYUjAKKQaH5TTUEUsgoyKIFqisu76V84g0N0JoL8OHc0dZGEXqYra?=
 =?us-ascii?Q?ik/12usWRCEe2+8ASOVjP1oF046n2JGOT/hf/5ajUHfI4hvq0J2C20U4yQFr?=
 =?us-ascii?Q?hl58Fqax3cjm6gW/Th+SYeddtLJ3Swr0M5xyqnqu/+nOPTa1aV4vG1AoW1w3?=
 =?us-ascii?Q?kjKZCzz3l0pytrVUCJKFW4g5RQefOWtZwTQ9GaToczwAFlKEe9/2u1LwaJem?=
 =?us-ascii?Q?YdDnaA31ovtoaoV2yvRq9OFF+0L9x9rLfQlKFcUWMAlun3Xz73zmj01q/ZQd?=
 =?us-ascii?Q?iD3rPeNiERe1XvIDxe7WvA1/84jpIUy75EQZSJxCHTIR3rGSoL5Mt4Miu5vP?=
 =?us-ascii?Q?3P884ealIzS7EG2GndRZHu8r/2XMxLWN0wlA6vPCWiYCq6W5JeMaJYCNcOA1?=
 =?us-ascii?Q?LclOwvI5jrlYP9Acc0aA63BIw57OFCI4M9ZFjIVo4NDHn0O1yPPDmvUFEdp2?=
 =?us-ascii?Q?NNQ2xANn4vFWYCDHkvNSZRbiz6m+aKe9EOZ6Q9goA8w8BqoiK+D/eXFumSM5?=
 =?us-ascii?Q?pS+qtw21m9h9yxxRLd8CAQ2/4i2GL6fy+aMQZnOkrnzp6ji1jVta/MCZ0P3r?=
 =?us-ascii?Q?7MX7uU5FrRygS8HTjT3iXnDhcab3F5fq1wbxlameK0YcJ3PICQNrREf3fKVF?=
 =?us-ascii?Q?WNfbKLIjy6X+6QgMKJb2AY++S2MUSiKj+IxYMe2zh1Q0GDuqdpbR21sWFhfc?=
 =?us-ascii?Q?yOzxKYZ+KkP1uC9Y3AlqI+Zj4okzgaKAH5cCVJ8D0pA/oEsAVmDHNezOnmP9?=
 =?us-ascii?Q?0Z3ssMPH6LKmG5Z/9Shq+K3iHCLg/fk5X946+bLQ5mAh4a/dZAAEPhmD5QMA?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB7958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec43a19-ee37-422f-a991-08d9ec542d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 05:14:12.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5KwCamc0YukgT0k1eYpFRe0hffF1Klzaizd+fPmpNM+euF3bqPzO4CPcKCRxr5pwUBAsO6GZ+vYhtUkMKTjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3989
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

Considering that 20MHz-only STA and one that supports other bandwidths will=
 not occur at the same time,
instead of a separate field for struct ieee80211_eht_mcs_nss_supp_20mhz_onl=
y inside struct ieee80211_eht_mcs_nss_supp, we can use a byte array as we a=
dded in here:
https://patchwork.kernel.org/project/linux-wireless/patch/1640163883-12696-=
3-git-send-email-quic_vjakkam@quicinc.com/
Instead of length field with dynamic allocation we can have an array of siz=
e 9 bytes.

Anyway most operations still need to differentiate between 20MHz-only and o=
ther cases, it will just change how many bytes those operations process (4 =
vs 3,6,9).

What do you think?
