Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89665761
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 14:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfGKMzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 08:55:21 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:28404 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbfGKMzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 08:55:21 -0400
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BCoboM022322;
        Thu, 11 Jul 2019 06:55:00 -0600
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2051.outbound.protection.outlook.com [104.47.42.51])
        by mx0a-00183b01.pphosted.com with ESMTP id 2tnxyah3ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Jul 2019 06:55:00 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay3RdJOSkEvDhap6VOCpXOTkqjNgJwG/fWox+xkl1886KBYaKke2fPPtnXzdHCzn9V92WRSktOKJ5bGsyXQvu2D1qM3ts92ucjxar32ddof27WHF6FslQEEUXHuFadalcBZhUo9eAEyrYN7ZnsX+pcztYRd4L9gPGIb2GriPDJaAEmQK/LP3e1I9xv5JN8GA3E1pb5ivi+WMHOh1IniF/BBjPW+cA/eNb6PxQIi0WwNKIpviHaqDzf8OoCr2H1+qp48tbhpeeGVTzT4UC8bojWx5ITwGVsI6ux214jK9Oc/4muS0pEUKgRno1mSG8tkcXEZTe+i/uIpXrdw+i5xR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO2iSO4+MKy8mqJ0BeX3elWoWZhzMhC08a0MtDB9Bds=;
 b=RXWNeCxMCGBgb3z9bpvve437lg+iDtCjeERvh1zUSLniyOfm2Zdv4gBw+C2AoGwDZWretBqWvqLc4o5a/WCdPMdtFssnKqor//+abRcvoCNgv3oJdt8QYXAa6GhNPjXhI6Hv2/c4GI3x2zJW+bCYa0dIbyS8rfFaAicM32YZCOuPqU8ntnOutiNK0uV1soe9s9N6Bc/Ey6Tmt4+Mrj0WqSN8DchD2JsulFoB4bL6E7BsIJ7R2gT1MO9FxJ73UJ66ga3D3K528OvtZPE24IL3tpmiySWvz9x5h8ic+fJRWmTjiNCzrVnWarNozU2XUmUs5hMOghzts5rUBwV7pOks1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO2iSO4+MKy8mqJ0BeX3elWoWZhzMhC08a0MtDB9Bds=;
 b=rmRgEIckxRNsxZAw0DDfhbiCWEyhzLXiIGspq60ttHxzPqNEuLNwDOnd79+GP5apHnw7g4OqO6k/5WJ6Kz3WLc1jTDex7F9ytxt5M8DyDYFcfnDNyFHYJKeGSVK1S+XKfi+Id5ZuhEyNo+2KVtN+9H92VxBwEnkN4S494oNsUTU=
Received: from BN6PR05MB3105.namprd05.prod.outlook.com (10.172.146.135) by
 BN6PR05MB3585.namprd05.prod.outlook.com (10.174.233.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 11 Jul 2019 12:54:59 +0000
Received: from BN6PR05MB3105.namprd05.prod.outlook.com
 ([fe80::a8c7:9a47:4458:f22]) by BN6PR05MB3105.namprd05.prod.outlook.com
 ([fe80::a8c7:9a47:4458:f22%11]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 12:54:59 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5647.namprd05.prod.outlook.com (52.135.111.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 11 Jul 2019 12:51:18 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f%5]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 12:51:17 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCHv6 1/9] nl80211: New netlink command for TID specific
 configuration
Thread-Topic: [PATCHv6 1/9] nl80211: New netlink command for TID specific
 configuration
Thread-Index: AQHVJaGvTjP0r5cPcEi6bnoTD8w66KbFg18A
Date:   Thu, 11 Jul 2019 12:51:17 +0000
Message-ID: <20190711125111.vd4rfixmotyusuai@bars>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
 <1560835632-17405-2-git-send-email-tamizhr@codeaurora.org>
In-Reply-To: <1560835632-17405-2-git-send-email-tamizhr@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:a03:40::49) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2e7e871-1d77-482f-11ea-08d705fe7715
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB5647;
x-ms-traffictypediagnostic: SN6PR05MB5647:|BN6PR05MB3585:
x-microsoft-antispam-prvs: <SN6PR05MB564711CBCFE8E21D5D280A77A3F30@SN6PR05MB5647.namprd05.prod.outlook.com>
x-moderation-data: 7/11/2019 12:54:57 PM
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(39850400004)(366004)(376002)(396003)(346002)(189003)(199004)(86362001)(6512007)(9686003)(478600001)(53936002)(4326008)(25786009)(66066001)(256004)(316002)(6436002)(33716001)(229853002)(6486002)(476003)(8676002)(54906003)(486006)(1076003)(8936002)(436003)(68736007)(5660300002)(386003)(14454004)(6506007)(66946007)(76176011)(66556008)(66476007)(64756008)(66446008)(186003)(446003)(102836004)(26005)(7736002)(305945005)(81156014)(81166006)(2906002)(6116002)(3846002)(52116002)(71200400001)(6916009)(6246003)(71190400001)(99286004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR05MB3585;H:BN6PR05MB3105.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Euj+f7CPDDdSA7UEwcxzTxAGezN8mHlQM4e4RfqEuJWaxyst95uGYEVJ2edx66PzwseNETq70fzu8jFrkp3DDbCmPs8yWr0LnoAA9LMkW52fK18XYsW7+Lp/0K9GtfbAUuHVK0wo6xwit15vex/vYGBwAok25HrtkUGbhtb5VlO1PHVzG+oT382jmDVHSK7u79liC0Xj78lgerYGUtpCnAcJtvakV6ULamjJz/hG0oOArOcvlRuR+NSHJgXJwhIFEd8Vb3HnoN5oep8Qr5mdElnRb5wbO7geyAAxGjgc5ea5yUHJv40xPi4mjHMC8xVBXKpMt4sB6SKbUcjXyQvrmgSoMx68q/lSSMbEmEmunmcO4w48hlQ15TsKU1ezZfDl8z13VNjj9q0rR6rqq+3mWuk1wnrBbpeBCHtEOChwZkM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0558E3923765CB498C7AE30F0AA63429@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e7e871-1d77-482f-11ea-08d705fe7715
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_7f80e2f9-1cc0-4787-aa3c-3cdfbd49c073@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 12:54:59.2992
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB3585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Add a new NL command, NL80211_CMD_SET_TID_CONFIG to support
> data TID specific configuration. This per TID configurations
> are passed in NL80211_ATTR_TID_CONFIG which is a nested
> attribute. This patch adds support to configure per TID
> noack policy through NL80211_TID_ATTR_CONFIG_NOACK attribute.
> Data TID value for this configuration will be passed through
> NL80211_TID_ATTR_CONFIG_TID attribute. When the user-space wants
> this configuration peer specific rather than being applied for
> all the connected stations, MAC address of the peer can be passed
> in NL80211_ATTR_MAC attribute. This patch introduced
> enum ieee80211_tid_conf_mask to notify the driver that which
> configuration modified.
> Driver supporting data TID specific noack policy configuration
> should be advertise through NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG
> and supporting per STA data TID noack policy configuration
> should be advertise through NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG
>=20
> Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>

...

> +static int parse_tid_conf(struct cfg80211_registered_device *rdev,
> +                         struct nlattr *attrs[],
> +                         struct ieee80211_tid_cfg *tid_conf,
> +                         struct genl_info *info, const u8 *peer)
> +{

...


> +static int nl80211_set_tid_config(struct sk_buff *skb,
> +                                 struct genl_info *info)
> +{
> +       struct cfg80211_registered_device *rdev =3D info->user_ptr[0];
> +       struct nlattr *attrs[NL80211_TID_ATTR_CONFIG_MAX + 1];
> +       struct net_device *dev =3D info->user_ptr[1];
> +       struct ieee80211_tid_config *tid_config;
> +       struct nlattr *tid;
> +       int conf_idx =3D 0, rem_conf;
> +       int ret =3D -EINVAL;
> +       u32 num_conf =3D 0;
> +
> +       if (!info->attrs[NL80211_ATTR_TID_CONFIG])
> +               return -EINVAL;
> +
> +       if (!rdev->ops->set_tid_config)
> +               return -EOPNOTSUPP;
> +
> +       nla_for_each_nested(tid, info->attrs[NL80211_ATTR_TID_CONFIG],
> +                           rem_conf)
> +               num_conf++;
> +
> +       tid_config =3D kzalloc(struct_size(tid_config, tid_conf, num_conf=
),
> +                            GFP_KERNEL);
> +       if (!tid_config)
> +               return -ENOMEM;
> +
> +       tid_config->n_tid_conf =3D num_conf;
> +
> +       if (info->attrs[NL80211_ATTR_MAC])
> +               tid_config->peer =3D nla_data(info->attrs[NL80211_ATTR_MA=
C]);
> +
> +       nla_for_each_nested(tid, info->attrs[NL80211_ATTR_TID_CONFIG],
> +                           rem_conf) {
> +               ret =3D nla_parse_nested_deprecated(attrs, NL80211_TID_AT=
TR_CONFIG_MAX,
> +                                                 tid, NULL, NULL);
> +
> +               if (ret)
> +                       goto bad_tid_conf;
> +
> +               if (!attrs[NL80211_TID_ATTR_CONFIG_TID]) {
> +                       ret =3D -EINVAL;
> +                       goto bad_tid_conf;
> +               }
> +
> +               ret =3D parse_tid_conf(rdev, attrs,
> +                                    &tid_config->tid_conf[conf_idx],
> +                                    tid_config->peer);


Argument 'info' is missing here from parse_tid_conf. IIUC, appropriate
fixup is included into patch #5. So it looks like rebase issue. But it
makes sense to fix it since this issue makes the patch set non-bisectable.

Regareds,
Sergey
