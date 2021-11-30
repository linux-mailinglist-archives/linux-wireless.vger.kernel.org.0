Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF06462E67
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 09:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhK3IU6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 03:20:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:6949 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhK3IU6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 03:20:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="299563210"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="299563210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 00:17:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="540331190"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2021 00:17:39 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 00:17:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 30 Nov 2021 00:17:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 30 Nov 2021 00:17:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfG1XNJvK/pmDZw2XRjXu108wtHr10b8kOd+BNg84iSBLh6ujfUWxT+Buj6KpooWIZU80c53AIZkZA7WLEZkLrigplgHAdwom3CqbDXIxq/nl7c13ZAel1ygWX92IMpwxm879jU0fXS9KjBnY27AqjjM28gh8vmxx6fOwYqW570irRxgwdisK7RYKDVrqqiyhLC5DFgSr+SEys1OxRn6m/WJNPbEgcj595MnTO2BxXcGZ45HEea2Z5qW2QeiQp1i+zjd7uS0xoA12sNJWmcVsf5SycWvzy9U3JWOmJ5FRZVi+9cuWJdPoK+3IgNx9am4f9t6Ke/J6zfDgg+LWvvxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdtkP9NZfh0t2ye2yCOc528DEQKOngNJ0b4dy10sB+Q=;
 b=Vmi5/8FCvasNvRxaVx50YWG7WtCW6AQs68B1LmGHb5oJvKIFVh6tVVd6yIH6yokfgTVXYQURf97AdoUQXAJKc0kkeigIn0Q3VmKISnoTe2brOjxTOyjBG1kZPtzrqhhuZdpfbX4aXgv+jT1mIvW03BBMr+7BzNkbiuiboBtqvGDzHrE5U9PA6K6vIWsyGm8C2BJuSfWVWbXRvz2RXHLBLjKrCvR1UDyMZbdfEXtov709inNAKMP+gAI2cXlFfBVukJ7MHlgfek4QlUEFx1pdhEnhBS3bQGdwkuqM4Soiujb1gbgye7wxWD0PvquAY9ND54/K/32Kqr5nFd9+pIoKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdtkP9NZfh0t2ye2yCOc528DEQKOngNJ0b4dy10sB+Q=;
 b=dO1SK1TqOqmUHvmC0VyliLfBS3NbZf4/o3hGcmTRrraS1u20fDNXJQ6vonucVHoJg3sFDmkktRGLeG4ngVg3wI20ozcHeCkUWIZiWK/1kvSgg+vYIqrOlrm5b2yo2V0JIAtqmjnafcr5NlDPnNP/2Yc1tgPaM2gwL90l0l/2fSI=
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SN6PR11MB3325.namprd11.prod.outlook.com (2603:10b6:805:b7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Tue, 30 Nov
 2021 08:17:37 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::787a:2f03:efff:c273]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::e814:a13b:4bbf:ef2%9]) with mapi id 15.20.4669.016; Tue, 30 Nov 2021
 08:17:37 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luca Coelho <luca@coelho.fi>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] iwlwifi: integrate with iwlmei
Thread-Topic: [bug report] iwlwifi: integrate with iwlmei
Thread-Index: AQHX5byIEmmivywbRkyKKA+xHudB6qwbuUkg
Date:   Tue, 30 Nov 2021 08:17:37 +0000
Message-ID: <SA1PR11MB582559489B02E37FAAFFEAA1F2679@SA1PR11MB5825.namprd11.prod.outlook.com>
References: <20211130073226.GA21360@kili>
In-Reply-To: <20211130073226.GA21360@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec20bb99-07af-4522-3f42-08d9b3d9dee8
x-ms-traffictypediagnostic: SN6PR11MB3325:
x-microsoft-antispam-prvs: <SN6PR11MB3325CF9396615CCBC8D6A96AF2679@SN6PR11MB3325.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZSy/FU6PA1AWsQ8nR/nR6xdJBg6omQsTGO/2LgptrOIk6HJoG5RlXryweMfhdyPZS5rJOjECKvkbVUOunQwplh/AfOpDMuSqPRTotIhjqV9CcquxoqDaW865e0mugLrFZ8WwkRIL1yUwJyJDCrKnPylpS3gXXuD7rUO2dJff2VTbaHUfHgQdnUYrksAQjMe6l6Dq0unoUCOZChuEx3/GRucutK6vbWnxUcgGA9fukd4DBwKkPciHRHtKAfR4XQw0nRArHfq5xfjT8az+OgCB60Gg9l1cFiSUjHa4D7HrZio2ZDIydG3vkpRgwphrBdC0KlbKc4tVvBVohwZWDusD26I/Hnuj7ygSj0vqT9Ro7PJ1gkh1OzI+igaR3r8SMz771dlmfozzr4AeoeUtwuzjjQAQ2w4Ped+LTm4PZATDebQX4O5bvhAF4EBEQQuCdP55vETWY5alsLMSCMM6k82JvzpcwHHdO1LEBRrdNbLCQA7W3/352feFaw5BGhKJThXGEJ7WP+3dfHAfmYUofec7IQ7AbTumxIlUA/Wai70dJYb+JJLBQ5Ke0OjlYjlW23sk5Cgqd/vJWKlP/us218SlH/v5u4PyRx1MV5eQOnus+/DhMx9xtUULlTEhbNccPjp5EyncZUmHm5wcct7DYG41TJaQp2IYuKJfl39ljVFhpZBB1fz+36+DAYhr9KczKRYUqrV/jpXP9YAm6JsVyP7/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(52536014)(122000001)(7696005)(38070700005)(86362001)(6506007)(38100700002)(64756008)(71200400001)(66946007)(83380400001)(9686003)(66556008)(82960400001)(5660300002)(66476007)(55016003)(508600001)(66446008)(2906002)(110136005)(316002)(33656002)(4326008)(186003)(76116006)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pweR53so8xmrht05pJOAYRHLHhHuSbh3VuRWmSm7hcdkUuCXZrfbk+MxO8wT?=
 =?us-ascii?Q?h6BnP7j8V9aZvShc1diyBYSN4H4FssIhRYj0Oh1ya/TD29S2ovQMPbTKljbe?=
 =?us-ascii?Q?7mRV4lQKnUeoIpap3W5y4w/M2wH9RlfGxPXyNLpY4CJ2XJ/Aa6BWr/McIFk2?=
 =?us-ascii?Q?8+XHxUoJjOxVGYs5YNv2pp2AdjtE0aiBvBzyKYtpfh3YIyjAPoX21c0pOenU?=
 =?us-ascii?Q?izI8GIgDRRVDEXtrpRGHvWUzDhmzq88eYt6Zm69mn8DRfYDKxaK1Iz/H/jnB?=
 =?us-ascii?Q?FQUm2LI4Zz5B9P2Wjz2b/1dT6JMiqj867RO75BouGL62/eugWUgE585CLt/u?=
 =?us-ascii?Q?821tmWJ7zFPoRT2KTR/reel1jP5j8WHtHbRC/WqqG7glmGwhZh8nnVwPIddB?=
 =?us-ascii?Q?PgbDWb3MsYgAgskg/wJsXdattq3ZZXgBp8K9E02GOHm1nnaVJPqu1pjLTbCd?=
 =?us-ascii?Q?7aYRlf/K0+/6x4QxeWS9TpdBz7DHhxU5QO3T31AH3VdWZaJfZwkmA1LDS6qF?=
 =?us-ascii?Q?golUwlVg3UCzUa9wQWSZHxkrVQwgtVvHOp/wY29a47K/7sYoFW6EhIyD/9Hq?=
 =?us-ascii?Q?dlcm7mTTOuWRM/3cOBdj//a+ky/UU9K9pH6yAQFU4fQeMHCo4hkkUeuCJ90K?=
 =?us-ascii?Q?ZbOoq2Z1QPTA3FK/NaIuCkPWsDBtR9goeT4nwQ55YNGzxdwxdFQ8b+WxZEQq?=
 =?us-ascii?Q?FB4/xakoXYS3cEeVPrMWz91OBhM284Ik7KpzFE3g/6J74b5tTAU5iYkvRNBq?=
 =?us-ascii?Q?AFzuKpLYIlbhhZnlD2ZVxRVZFuyP8OlW0bF8TAk8pATH9CKjUPhBD0qEKL6O?=
 =?us-ascii?Q?FAXLGkAqWpEpmFnMocdl2Ial8yNGQgpd3DGh5A+ye6zOmVZtu2YAakrT/eat?=
 =?us-ascii?Q?MtM8tIKgff8V+UbzqYGrXDtoHVn56YwsJcpFee4rGI8cDi6DSKb6LyuwyQWh?=
 =?us-ascii?Q?EHScyML7toq8LfYY2H2CqTbDIU0Hp93VNLKeIfW0oacYkUFYAj817DeERJJc?=
 =?us-ascii?Q?3CzUcgnhVAyUoSHoXmudHkyG8ywBCN8otJ1qFLB3pSYQU5WKUn5EQ8nvfd+l?=
 =?us-ascii?Q?sK5jxK/Q0C4yyYyCXrwHUT6E/2s9LnNrzKVzmkeM24eq7QK9fo3gysfRzULT?=
 =?us-ascii?Q?HVZiXw2S3R0SIgOpnjcqzZ2a+X8xhJTADXBKrjoIVbRCPkj6X1+O6t0NlXR4?=
 =?us-ascii?Q?ieQIHds3QQL1V2W4MSRGrgiErmzjMPxJGFJeY2DN9ftEhJzOH3DqJajpIwbd?=
 =?us-ascii?Q?58vXW95PpT/JWUKxEn+4rWIh+P4RczdXbJ2r1p58eAHHuVZH8cABKV+DVc5q?=
 =?us-ascii?Q?yXWbMjrD9T1NIHIKvobJ63L/rv4lcHQhhDmT6v9lCORRHfnnYX48irS772YZ?=
 =?us-ascii?Q?e3m165SaOJNOwBay1J/5LcEYpT4gA2bW1AepdOEce/Ba7JBLKirfTHj/bH0j?=
 =?us-ascii?Q?ZJqBPLHrZ3s1ntA7lAYSOYCy5uh2AsgrlY+1I0vhscjG08bmWbdNMMa2UdVU?=
 =?us-ascii?Q?qGudo2/V8oQhV6qXlFIiaXIKbio9Wp4VCQo1BJQHhPqG8FnCNsK80UbIYLi/?=
 =?us-ascii?Q?wA5oHISz1o8lCvcb1Hg+4SHsqt9pf43KU/ZU7YzEMhjWrH8A1ZiFIzTCvIGp?=
 =?us-ascii?Q?dpzRMqI3oeJngnwjzgrR28O2CJYZlo+GIpJ09bReFtCkzPokC9Z4g9TIEc/q?=
 =?us-ascii?Q?KIBvvw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec20bb99-07af-4522-3f42-08d9b3d9dee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 08:17:37.7438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OLTnPJ4FGcHkLD1IQu9YpgQMUENDSyJStRed+apylrSo0uANQcgbybV9JiPHghE1sI3PWg4V9MwoCbSH5ipOfZQnFAIeZpl1/zBM/clnJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3325
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

>=20
> Hello Emmanuel Grumbach,
>=20
> The patch 6d19a5eba5cd: "iwlwifi: integrate with iwlmei" from Nov 12, 202=
1,
> leads to the following Smatch static checker warning:
>=20
> 	drivers/net/wireless/intel/iwlwifi/mvm/ops.c:740
> iwl_mvm_start_get_nvm()
> 	warn: inconsistent returns '&mvm->hw->wiphy->mtx'.
>=20
> drivers/net/wireless/intel/iwlwifi/mvm/ops.c
>     684 static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
>     685 {
>     686         struct iwl_trans *trans =3D mvm->trans;
>     687         int ret;
>     688
>     689         if (trans->csme_own) {
>     690                 if (WARN(!mvm->mei_registered,
>     691                          "csme is owner, but we aren't registered=
 to iwlmei\n"))
>     692                         goto get_nvm_from_fw;
>     693
>     694                 mvm->mei_nvm_data =3D iwl_mei_get_nvm();
>     695                 if (mvm->mei_nvm_data) {
>     696                         /*
>     697                          * mvm->mei_nvm_data is set and because o=
f that,
>     698                          * we'll load the NVM from the FW when we=
'll get
>     699                          * ownership.
>     700                          */
>     701                         mvm->nvm_data =3D
>     702                                 iwl_parse_mei_nvm_data(trans, tra=
ns->cfg,
>     703                                                        mvm->mei_n=
vm_data, mvm->fw);
>     704                         return 0;
>     705                 }
>     706
>     707                 IWL_ERR(mvm,
>     708                         "Got a NULL NVM from CSME, trying to get =
it from the
> device\n");
>     709         }
>     710
>     711 get_nvm_from_fw:
>     712         rtnl_lock();
>     713         wiphy_lock(mvm->hw->wiphy);
>     714         mutex_lock(&mvm->mutex);
>=20
> This code takes three lines.  I'm looking at linux-next next-20211129, so=
 it's a
> little bit different.  The original patch is buggy but it's made worse by=
 a merge
> issue.
>=20
>=20
>     715
>     716         ret =3D iwl_trans_start_hw(mvm->trans);
>     717         if (ret) {
>     718                 mutex_unlock(&mvm->mutex);
>     719                 return ret;
>=20
> This only drops one lock before returning.  It should probably be a goto
> unlock; and we add an unlock at the end of the function.  I would send a
> patch for that but it gets a bit confusing because of the merge.
> Emmanuel, could you take a look at this?

Luca has a patch in the pipe to fix this. Clearly, we had merge issues here=
.
Luca, it looks like the commit:
"iwlwifi: mvm: unlock RTNL when starting HW fails" is the one we need.

What happened here is that, internally, we had two features that were imple=
mented
in a certain order (iwlmei before the load of the regdomain in INIT) and up=
stream
they were merged the other way around. This caused merge issues that weren'=
t handled
properly apparently.

Luca, can you take a  look?

>=20
>     720         }
>     721
>     722         ret =3D iwl_run_init_mvm_ucode(mvm);
>     723         if (ret && ret !=3D -ERFKILL)
>     724                 iwl_fw_dbg_error_collect(&mvm->fwrt,
> FW_DBG_TRIGGER_DRIVER);
>     725         if (!ret && iwl_mvm_is_lar_supported(mvm)) {
>     726                 mvm->hw->wiphy->regulatory_flags |=3D
> REGULATORY_WIPHY_SELF_MANAGED;
>     727                 ret =3D iwl_mvm_init_mcc(mvm);
>     728         }
>     729
>     730         if (!iwlmvm_mod_params.init_dbg || !ret)
>     731                 iwl_mvm_stop_device(mvm);
>     732
>     733         mutex_unlock(&mvm->mutex);
>     734         wiphy_unlock(mvm->hw->wiphy);
>     735         rtnl_unlock();
>     736
>     737         if (ret)
>     738                 IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", re=
t);
>     739
> --> 740         return ret;
>     741 }
>=20
> regards,
> dan carpenter
