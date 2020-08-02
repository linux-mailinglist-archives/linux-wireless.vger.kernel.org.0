Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC81D2357DF
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgHBPC2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:02:28 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:3233
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbgHBPC1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQlvu4jh69PE7auzO8nERJTBsoLI/moFfs43l6bhEzg5cqMxaMck3ltV8N3MSGnCyzNzd8RIp+9p+ZhnZGQpyYeQXtWJ8dY4bCevciboBYtOBXRaaY8V/2NO7GZLqClxN+YFYWyq5BBBf4A/5Us9fMyXeYOYvJlKbYsMr1zWE5zGbS0c3ZIoFIOo4NnugNWwdZoIvQFu/XJXPM4HOdPq7aDVSlt7EJ3DslBniNVWmj4oHWw7oaPZHmc76EmbecFu2BVHeuUc7LjJ7RW6vwYu/mwFfgu6g2Ah2OlWJ9Tc+8ENBsvHAlUMZOwAwjVJmLAxGFafL+p36Y0ztwyinQRRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhWu7ttei9OPftnCg3nyyFh0XXyNKUHiP7OjQhoUVl4=;
 b=HqKLNxEl5Odw+6dXjsnuvFCvIp4nwYE6OrgI+znCNCEW+QTaM8q1k4keZY+HI1eWgJcMWTMpkkz/7vyutbPnTSOqvFcMKvboqEWms7xGAKGc9lF1j8ANfbWGrBnthjTCJVU2wmaLPj5gC00YLgQEwcsjvvWyTinH5FLHWp840o1LVIsFwlvu17ko9dNsYSMUr5nW9OmXv45nx5oSPdat/vLGJFNrDgrUFKeLw74Gkrom+U+z+JhszhCoIrcVSSZkMSrC2HqMLuY0Z3H/toDxpxqUtWeClsJ70jhNdx5lyzITlw3Mw7OwtaM16rvjpXEa1OGsQ+dkQivINdd/tGqovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhWu7ttei9OPftnCg3nyyFh0XXyNKUHiP7OjQhoUVl4=;
 b=GhP53AKuNkdVhuR0WjxNvOu6esUc+eFoHfrur/34to3nPiNXrBOdF0QHb5Q6DhBCMcXgnPHiBF5F/m38HGhHGkwrOpb3EWn0zVFkZlPW6uYQ4EmQJ2f+/LdIKDcNK+lUjmojIBItTqV8AM+JgTy1JYxIL0k4k+v+U2eXaZxitBA=
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM8P192MB0947.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Sun, 2 Aug
 2020 15:02:23 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1%5]) with mapi id 15.20.3239.021; Sun, 2 Aug 2020
 15:02:23 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: Re: [PATCH V2 06/10] ath11k: pass multiple bssid info to FW when a
 new vdev is created
Thread-Topic: [PATCH V2 06/10] ath11k: pass multiple bssid info to FW when a
 new vdev is created
Thread-Index: AQHWU4v0+suHmnhIfUW2oAR1X5YMWg==
Date:   Sun, 2 Aug 2020 15:02:23 +0000
Message-ID: <AM0P192MB0468CC75648CE04D26CF58C3E74C0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20200706115219.663650-1-john@phrozen.org>
 <20200706115219.663650-6-john@phrozen.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: phrozen.org; dkim=none (message not signed)
 header.d=none;phrozen.org; dmarc=none action=none header.from=celeno.com;
x-originating-ip: [87.68.129.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcf1dc7e-fdf6-4f97-56f8-08d836f5102d
x-ms-traffictypediagnostic: AM8P192MB0947:
x-microsoft-antispam-prvs: <AM8P192MB0947B28A8382E78BF6EA3EC5E74C0@AM8P192MB0947.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CWxdstBx9KkDtXPHrp4MHRISwiA/YGSbzSY0o4xeld8nNx3WFfroEuSgPEYQCbpvdXzOyyFYrMA54lgLyI2xM+cd1ZbD0+s7d7IImJK7+t7aXQeA4jx/zo2WkDD6TUGkmslkPQPS3KrTQLxvKESycZxLbxBCbp8ZJbcmpC6ugZnB28HRQhTpsNEqUixjmSYmscdeZzG7/uyNGzqX8lo4FXJ5SXgmaPkoG/xcMzOHxBZet8mKs4+84JFToLSIYI1fmuAkFMyijzv63R2y02pA3vck7//t3GPb6QZR3DlOAQ912w3HLoRRbvMceHNetCbnqia9WVNUQ8UVspcxV53LHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(136003)(366004)(376002)(346002)(396003)(26005)(76116006)(53546011)(71200400001)(33656002)(478600001)(8936002)(2906002)(66446008)(66476007)(5660300002)(6506007)(8676002)(64756008)(55016002)(7696005)(66556008)(9686003)(66946007)(91956017)(54906003)(52536014)(83380400001)(4326008)(316002)(110136005)(86362001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wSLW5ftPDR4iDlqnFspa0mAKXB62Io/wbbS6uPySJmLKHSQC/IliZnchA6OpAQKS67x5cMd/ZQHXQGG4Heqo/+JhNjMmHKJMxK+RPxU5/Dsg+Ad8UwxyHREtMMRTxuThZxx2ydis0eGeytMhnvTBVDreyfEZrrIu3TWSOCNxTWIBIphgIWT51ptIcpK4alb5Al5eqCN/s2ieBhxqV7h7d9yqHqoHdgvmmaHvExMVCw7D4yEFdUMhpZfXz6Z3APUbb5z3GwhXPZG5XSEFdtbmYGYoH/l92lPDUBYpmsQbqqmSrlA9YkeQ5kyUtkM/S35a2/9Wq2mKAdKM8NgTO2H1uHuKk3mvVAucH4NhZ2uvgyUilaYtJMaDq1N7AjPRYxxBiPho3Feeq25j2XlL/PAMCdzQw88HUVCd3sMN3py0t3OMCtUWiMlUfzRYEo1OYORRsedKvixuFlGjy70Wd7LJHi91SOFef0BgjaTpRa0m6oq9+qymriWcOJ+vs5zHxSv7BO7I9So7beVYXABETtzhIPuS3J6M9jUj70eq2nI+9Qrlyhk6zvql08tci0twjgEm7oQPdpSaL2qf9f26Q4OJOgJD6xcaVzYHPzdUIEaItY3MoTlhFQ34syHqS20f8/TO3lMxFaP0XVyiALsUjkrBNg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf1dc7e-fdf6-4f97-56f8-08d836f5102d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2020 15:02:23.8130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSKqcbkRfPdCbvpm0BXns0ZzJ1g6kRxAJ1BPeeR+ahSeI729d64j65afSfr+ZL7vJzRPCASaC0jo64QrJ1Hp2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0947
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/07/2020 14:52, John Crispin wrote:
> -static void
> +static int
>  ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
>                                     struct vdev_create_params *params)
>  {
>         struct ath11k *ar =3D arvif->ar;
>         struct ath11k_pdev *pdev =3D ar->pdev;
> +       struct ieee80211_vif *parent;
>
>         params->if_id =3D arvif->vdev_id;
>         params->type =3D arvif->vdev_type;
>         params->subtype =3D arvif->vdev_subtype;
>         params->pdev_id =3D pdev->pdev_id;
> +       params->vdevid_trans =3D 0;
> +       switch (ieee80211_get_multi_bssid_mode(arvif->vif)) {
> +       case NL80211_MULTIPLE_BSSID_TRANSMITTED:
> +               params->flags =3D WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
> +               break;
> +       case NL80211_MULTIPLE_BSSID_NON_TRANSMITTED:
> +               params->flags =3D WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
> +               parent =3D ieee80211_get_multi_bssid_parent(arvif->vif);
> +               if (!parent)
> +                       return -ENOENT;
> +               if (ar->hw->wiphy !=3D ieee80211_vif_to_wdev(parent)->wip=
hy)
> +                       return -EINVAL;
> +               params->vdevid_trans =3D ath11k_vif_to_arvif(parent)->vde=
v_id;
> +               break;
> +       default:
> +               params->flags =3D WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
> +               break;
> +       }

Hi John,
The ath11k_mac_setup_vdev_create_params() is called from the add_interface =
hook
which is called from ieee80211_do_open() which is, for the first (TRANSMITT=
ED)
interface, before wdev->multi_bssid_mode is set to NL80211_MULTIPLE_BSSID_T=
RANSMITTED
(set upon start_ap from hostapd).
Can you please explain how wdev->multi_bssid_mode can have
NL80211_MULTIPLE_BSSID_TRANSMITTED value in the above code ?

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

