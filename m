Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDECC3166A4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhBJM2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:28:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:9504 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhBJM10 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:27:26 -0500
IronPort-SDR: TZOEjna1MtI2m9Lol1CkNAiFw6GF/QgJoUK6Nw+CSjnmS+rtgRy6a4OgYWxZVTy9gaIRpN9F5z
 XvnDO7oteh8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161210602"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="161210602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 04:26:33 -0800
IronPort-SDR: S0uH38uaL7KaV1EKDKR0jBi/74dDIMIA/5J3iY8T+noXQav3c2QtBMoTPj4wCr/5oU444IyaJQ
 eEF+cdjoPgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380084111"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2021 04:26:33 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 04:26:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 10 Feb 2021 04:26:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 10 Feb 2021 04:26:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOzA9ayk11Noip7yXV/FkLdI4FX767ENQRhB2HZQF1eg7gPnXSbQ/MK7T2Kfyl6Vz2QBtIahbHAKpbDPXWNIWUdenbFDPI4RZcjtOiiKEecaIHU04CntILqGMa0Gkx1GT3v0eV32odf6nfZexSjHalhPf9LRQESlyqL2Hzv+vb1nZscfH74Z/+3Dacz5gCUxRsoSaQqRVFJb9rTu64HJEo/2fnBn9CtDbH3Kll13E2Ay9/n6EUJ+P6/yTFzRDJ9gXsqqqBl+O21Nb8AVDwUj+5HFtB4FR9kz6QMlPTi78R8IGZwmSEsUjCBuJNNz8i55qLxuzIlxkmHuT02F0LtZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cvk3WXCYkDILU5eT13lrL9LbkMzfuSsPckxe05kK0I=;
 b=HjS5QuGAmGtjJEgZ/UaJ/YRI/too9/00YtudeUsywDEXqYi03Z489cdg6Tj+LlmJlmKc3R84OmyAj692U74gawYSfqOSXzRg0FutEqmnNiNcP7qJs3iFD1SBJgxKwn1g/o4ddxwVGAUZ9r3AzY47OowoROuWCHNV300VnAWiMLa9u3Vwu99tTvZbz2tP4CBX7zs3RS7ngrAL3EznUbxwS7As4/wo7HF6cTvhFZerOCXbcu8w7/72fZOb8AaDeJInHGHnNOi8kfIh5DTjwpOTbcLenjVSiKOYySKVR3h/1J7rE0nl2OUI1bcgQOqQV8mIdq/eEMx0bboUf8utmYGyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cvk3WXCYkDILU5eT13lrL9LbkMzfuSsPckxe05kK0I=;
 b=nfz3QgeOni2Cd/QmFiZEDFXXhVbn78fm19LAiO15S3J0RUCsEcwmw2vHVLms9nAQ3/ZQSfnbIKg1LLLBXyw8ec0vk1vKVoWcSNEMIfFybM69ec1SPBUBklX+qd+qnEoNqLJ9Y+EsWfABns9oBccRDPtV0QgVPMBklmxbFhUva2s=
Received: from BN6PR11MB1539.namprd11.prod.outlook.com (2603:10b6:405:f::15)
 by BN6PR1101MB2081.namprd11.prod.outlook.com (2603:10b6:405:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 10 Feb
 2021 12:26:32 +0000
Received: from BN6PR11MB1539.namprd11.prod.outlook.com
 ([fe80::41ab:6b6b:46a1:4538]) by BN6PR11MB1539.namprd11.prod.outlook.com
 ([fe80::41ab:6b6b:46a1:4538%8]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 12:26:32 +0000
From:   "Stern, Avraham" <avraham.stern@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: RE: [bug report] iwlwifi: mvm: toggle tx antenna if tx fails during
 connection establishment
Thread-Topic: [bug report] iwlwifi: mvm: toggle tx antenna if tx fails during
 connection establishment
Thread-Index: AQHW/5tJrUIzt0cmHkKnZtyf2ByQqapRTfSg
Date:   Wed, 10 Feb 2021 12:26:31 +0000
Message-ID: <BN6PR11MB1539F4E287D03E2F23723B8CFF8D9@BN6PR11MB1539.namprd11.prod.outlook.com>
References: <YCO7gahK0ktH8YkY@mwanda>
In-Reply-To: <YCO7gahK0ktH8YkY@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2a01:6500:a039:50ee:13a6:c744:1dac:931a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b89a0d2-a4fd-47b7-1713-08d8cdbf1959
x-ms-traffictypediagnostic: BN6PR1101MB2081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB20814B8E9D5014DE0A591BC0FF8D9@BN6PR1101MB2081.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S3sDPYcOXI5SS90vRS2wS040+EEJWZzCVPTNbBb87XfA0bsPtChqM+vAUZDWbQtf4aHluCET7hXszqtTyS0mvzctgNtzgLozs92n4LWqzvQzN5N8BQv42V46gEV2ISPCRZFUeVkCt3+gjI+r7WmTrXUF4hyO40bXwZOUvSTVs5c5En8Vnhc1dMDDJs8ZTQ90+MWgitNiceCIW68RSXvn3QmSenyqlOdeWy5y05tMUbxPGeQfV/PrSSE4iW0KzQ7sAlog7BesI0oRLzqUb0x5sEpDdLwYH6jC+g7eIlCCZp1RRL+i4FfaNYsKWrm/0vfmENVK7yKUpdu4Z1ZxG8PDM+2QwNZHEJQFFXZOW41bTEdEbYA23VCNRi4FHxKiIZchW/LHuzxI6e6M8bad1qM7zL4aLOxxEPllbUdLKnPicbS+HXaF2lcPdi4PBT3sunm8cMQ2b+FKsLNmquNQp/ykRJ6N8be84D5IrWTYpVqL5bUOKX3Lo6I/PVZLxPAjtUcsjSk4DhyFR6O8W+Vf4CzS5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(7696005)(5660300002)(86362001)(478600001)(186003)(6916009)(9686003)(8936002)(66946007)(55016002)(316002)(66446008)(64756008)(66556008)(54906003)(66476007)(6506007)(53546011)(52536014)(4326008)(71200400001)(8676002)(2906002)(107886003)(83380400001)(76116006)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1azIK4mkrww9shtz5bY8+ebZ+7nPm0L+Iz0LeMHPfp4X+cc+Dp1zycMGv8qY?=
 =?us-ascii?Q?6VO2Mc33ukkztZJspx1jynaTag0pEyrediJhGFXomU9QSlFkQS1yAJONpSIt?=
 =?us-ascii?Q?JaawOZ8Q93IBrjgcPa4/Yzne+O28v2fgrniRv1lNXuX0i8C12+w1F6YTjNWu?=
 =?us-ascii?Q?fJ+d/XPGnXDocdP1OgmPfGbX+yNZaJ/gfz6QkxOOYk356myMTIcsBHdoqESv?=
 =?us-ascii?Q?QMVdspksEQ4fzpeHndjFu6Ijm/FCa+xy+aoeGA6z/3sNJlOQWYhe9I0efaus?=
 =?us-ascii?Q?LJxUuu4ybDpH2txjKjDYj0xJcoN02CJnzv7MgNS5XE/AVVAEhiRNiQfo2YdM?=
 =?us-ascii?Q?gzjBxkNnBI0WUixn41wNRhnxvKx115rLeC4ttM8Pisp5xMqqjltq9H+JzH8d?=
 =?us-ascii?Q?AH3KhgkTsoyFO+rR+RmO2h5U6/PjWqRJv63AtcyYLalnSII/8JPGqt4leNfu?=
 =?us-ascii?Q?IrKmOR5MaIkbVySMmZWAY/OtmoCdmQ+GYtauq+0eH1TVLt+BgNCW2THbHT1E?=
 =?us-ascii?Q?4c98xGa5EXS8XQ8/SpJJGNsXIvIUM5t2o5p5JUTfKLduU4deNNXUFbuZGllz?=
 =?us-ascii?Q?tRv4TZZ9LUy1BYN0kW90Hv82TG9BviJOU5cE0nBFnAZPFIrEvel6FMOTCuI4?=
 =?us-ascii?Q?KBIAxHJS2eYecwf1DoKUE4QW8jbhGzxKHcqmw3VqUMwI7AObzhiWEWIk5HOS?=
 =?us-ascii?Q?zEAEnlFkvoAHF8OLqLuoVBOBlDaejWOdilRhPxk9F/hHF5U7GN5pVWfSzDZx?=
 =?us-ascii?Q?yWC0bF2Nok8itH2jBPWYwETUnzEHU2HRHttMisu0d/LVRw5HMlwKSskPIWCx?=
 =?us-ascii?Q?AAVvLeE1kdOah5xnR8MpM1wBkz6nBZneG5D6uyYR7K3ruNDhUL1VUlMSp4xn?=
 =?us-ascii?Q?VeSoaKLrPfJUqnkz159uolYcNKuoKuUVLPIaNMWt+j/mLY6iyxT6kWkl9q5M?=
 =?us-ascii?Q?BkMpv3T3iW1k50gnH6YPg1eZriGVuGYddMoJW2/yw9GSBLlAg3UEhY7T52G9?=
 =?us-ascii?Q?mfehVuy4vX6wwNurHwXqRgXvp2FGKek1SXqCJz4Kyw5mWQkD3RNsn+fxuHSp?=
 =?us-ascii?Q?N6h9DnY9HdDilPJ8bmQRLiT/hDBOE6MM34i8P5cVLnTITddk8ur/dZQ5F9Zx?=
 =?us-ascii?Q?cdhHih46QlDgxhdVqsCZqyjV+yUc0f1qEcN70p+6K8ZWtpoAeTUFbljQaPXK?=
 =?us-ascii?Q?B3MzFoyeW7sz5YHtmU+lFMrMkQaj7uMv0jY93KoWfhlsmFoVC7XFQXz6CwhJ?=
 =?us-ascii?Q?WbmhhIXm1cvaictu3LHkEgmqTjcO9rsqL+RQ/X2jJUB7aFevYxIFiwa27Vmn?=
 =?us-ascii?Q?FAq42qOm2Y+nnAnylF42i/kYhbJNB9wfZugbP/VhqW2VnZMRxr+hLB97zIQp?=
 =?us-ascii?Q?Wm4WeUfsgVnSOziL/xb2aus4AeYF?=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b89a0d2-a4fd-47b7-1713-08d8cdbf1959
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 12:26:31.9962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJGjF9hERvSQWjx1X16UN7jmgc4jMxuUUqpiY7Yr5O47Tv9x0Y/+ylvAs+QWTd9TsBmR4/YaQQPZT7fJAOhSKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2081
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

The offending patch that caused the Smatch complaint is:
"iwlwifi: mvm: add explicit check for non-data frames in get Tx rate"

this patch adds an unconditional dereference of the  sta  parameter in iwl_=
mvm_get_tx_rate().
Before that, all the code paths check for the NULL option.

(this patch is from the recent days, that's why Smatch only complains now).

Regards,
Avi


-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com> =

Sent: Wednesday, February 10, 2021 12:55
To: Stern, Avraham <avraham.stern@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: mvm: toggle tx antenna if tx fails during co=
nnection establishment

[ Sorry, I don't know why Smatch is warning about a three year old bug
  and I'm not sure that it's blaming the correct commit but the warning
  looks correct.  - dan ]

Hello Avraham Stern,

This is a semi-automatic email about new static checker warnings.

The patch 0dde2440a77f: "iwlwifi: mvm: toggle tx antenna if tx fails during=
 connection establishment" from Jul 11, 2018, leads to the following Smatch=
 complaint:

    drivers/net/wireless/intel/iwlwifi/mvm/tx.c:356 iwl_mvm_set_tx_cmd_rate=
()
    error: we previously assumed 'sta' could be null (see line 341)

drivers/net/wireless/intel/iwlwifi/mvm/tx.c
   340	=

   341		if (ieee80211_is_data(fc) && sta) {
                                             ^^^ This assumes that "sta" ca=
n be NULL.

   342			struct iwl_mvm_sta *mvmsta =3D iwl_mvm_sta_from_mac80211(sta);
   343	=

   344			if (mvmsta->sta_state >=3D IEEE80211_STA_AUTHORIZED) {
   345				tx_cmd->initial_rate_index =3D 0;
   346				tx_cmd->tx_flags |=3D cpu_to_le32(TX_CMD_FLG_STA_RATE);
   347				return;
   348			}
   349		} else if (ieee80211_is_back_req(fc)) {
   350			tx_cmd->tx_flags |=3D
   351				cpu_to_le32(TX_CMD_FLG_ACK | TX_CMD_FLG_BAR);
   352		}
   353	=

   354		/* Set the rate in the TX cmd */
   355		tx_cmd->rate_n_flags =3D
   356			cpu_to_le32(iwl_mvm_get_tx_rate_n_flags(mvm, info, sta, fc));
                                                                           =
^^^ It is dereferenced unconsiditionally inside the function.

   357	}
   358	=


See also:
drivers/net/wireless/intel/iwlwifi/mvm/tx.c:486 iwl_mvm_set_tx_params() err=
or: we previously assumed 'sta' could be null (see line 482)

regards,
dan carpenter
---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

