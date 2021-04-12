Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79B635C7E1
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbhDLNpW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 09:45:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:32110 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239682AbhDLNpV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 09:45:21 -0400
IronPort-SDR: NFJal49cRrCRsYybg/wSaqbpDS0+jf/qbkhYOWSvs/agFM1Jha99n/dCo13luzNhRbEq5xOZHJ
 ojZ9KL3ARQ9g==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="279493853"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="279493853"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 06:45:02 -0700
IronPort-SDR: ndW5IewoxO37NYU6BGA/cf78dsI4h6agm/UYDlMd4Lyft4bkE7KQbDM/v0IRkgoQCWFURxaxD/
 jH/WuS2WVWlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="611367943"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2021 06:45:02 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 06:45:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 12 Apr 2021 06:45:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 12 Apr 2021 06:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxeoR+qH5IVPFtMPtQz8gsQbfTTzPeUoHcFmsNIjzn9SPxX+g3Isuj/ghxN65FbVS5vYL9kxLmpdeFzrk4hDBCnhRw54fzlp7dbV16wIkK2s/Ezz9tfZ9OD47ZUO7W0xID05bJ8Svmf4lO0j+RPg8rwn/UnxTq5kplmuGweGuEN1fGBp49EE6Wb50rukORmqnT/w9v8/0KE7DtmHQcBh9CzMFKUSQ2l2steVwOMD/V38W4uLZZwdxpKlBgF5JZi8c9EeLnmCzFPhnokO2ddZ0q8pkCaqQ8K5876w2xu4IPdpQdOF/kX/zXEYEjJqF8vfBKrVS0DaAhp7qrZiQE3Vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTCR1WgFOp9emrnrqnnyZVn+xNRXRKdOF/ssjqwAm4A=;
 b=mcRxk/vnMpLvqDH1eoCW3Dk6AweCqENmTQ9CS9Tds6g81kyY8NbKK6CBSNGmNtbs7w8fgyfbfrS7cJ3r0TEdLPebD54nMtJCOHF2ZOtrooxIecyPCfsmtrAEYitmhjL6yRMzKRdB0wj37vwPRLJXbUusNNC0rd16iYcb6St5QtQi6C+kT6HcmQK2nXkMG9ysbkVhyUWzoVrXjDcWQQSUpa23LhNlF/OobxFmx2CPLgtLk2norZ65U1YmmS2smmbLrwF8wh2hODZRjFolaF+VKbjJcQkU3yPV/Grkt/rt3keqKUUsZlxDOkjN234GsKPeHVD7p0vxG5mApMZ7zY6JLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTCR1WgFOp9emrnrqnnyZVn+xNRXRKdOF/ssjqwAm4A=;
 b=YWWM/LD/OcVur3iSjBMoVpNqoY0KM4TOzvUiIK07yGrUmon18CBajrdC5JNNzlHWTuLdNVEoYQWBWTCFSgQhPpQfHgXV6PqDcvIhf2a2V5GKKQx9ijc7+22W3w1+Rra0xHV3sj85814Cf0RtESOYT8yzui+7iS1ERoVJQvfU2lo=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SN6PR11MB2703.namprd11.prod.outlook.com (2603:10b6:805:59::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Mon, 12 Apr
 2021 13:44:58 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 13:44:58 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "Beker, Ayala" <ayala.beker@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: RE: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Thread-Topic: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Thread-Index: AQHXL5l8AAlmpHtWLk6IhaLef8ZD26qw2g6AgAAEIoA=
Date:   Mon, 12 Apr 2021 13:44:58 +0000
Message-ID: <SA0PR11MB475215678ADCCE657C6574D6F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210412124328.24472-2-emmanuel.grumbach@intel.com>
 <YHRFy3aq/gB7Vde6@kroah.com>
In-Reply-To: <YHRFy3aq/gB7Vde6@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [77.124.181.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b773f310-47e8-49bd-eff7-08d8fdb9299f
x-ms-traffictypediagnostic: SN6PR11MB2703:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB27036D9A6B24415E58426C7AF2709@SN6PR11MB2703.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AAkjmKhqq+rnJdt+6Tf7t+dXwmcD+MzmafTFuKkXSZpEwgL4VtcyDe9QwZmLe2XXCQM7FHScsFAE50L5OJL/1tGcniWqRHbfDHt62veRuCERunuvP2V94QedmM8bciT7y3gvWIyuwCnzibA4li+bBre/64cw42hkYFmFejVgnODxMFA+hpEXBwEcDQbZ1k40mRC5GODyxKGnE3jIc7451iTl6p95vba7tuhPuTQTEtX+UglD/Q3vkDQyio8KhDej20FzzWaABW6sBiCPENoJxYL/SJMvmk9F0niSmCOtA7+a66BcQwnKZlvJqpHKkLAhst0s/QCrobIUtuLXSznteN5634SK1Qx2HdNv8EDQwX4PF/QJIN4rEOcpdYP8TdnMlnccpdj8vnA4RiG+Y1xbDyW/oNHvt/26kCvrbntW4aP3lNOu1zp3rUaGshwMOmT9JvS0a7g1dIw8jXzWiS26SKcA4cXHyiRlgeA8g4qzbEV6ThdRcE5jv50qtfr20IMl4J1JHyTGH6xIk95DDyRObgy+xyXFbEq/JykWavzIUpgGtvIzLH2taxcUmFsgznwnILMbEJ94o/IyySdknc2cYYgnQReLwBb7iENr4/XBXVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39860400002)(8676002)(478600001)(8936002)(4326008)(55016002)(107886003)(86362001)(54906003)(7696005)(71200400001)(76116006)(9686003)(6506007)(38100700002)(33656002)(6916009)(186003)(66446008)(5660300002)(83380400001)(64756008)(66556008)(2906002)(66476007)(26005)(316002)(30864003)(66946007)(52536014)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZegGbZSQK9JpY1icbDPB9yiqydS7Lok+yPq9Y/NzC1ujvmtZErqHQ6Tx0tizE5HRjm192Yu0ysTYSD07Yc82g9MoJ4+gFQdp4ee653nUmYh4KLlpd+kGCtf3agoxN0y5kdjYGYcdFpcvlhQmV7RnM586wHNOkfPUyBj7ixy9+YVbNVVfBMoiuaKutMHVVGzhG9j7WMPMBQZPbRGNxTQeg/eiEIOv+CsmIz5ZaiSz11DK45sPdTxS6c+Cg1jNfmh+l9iwSvrgUdrw3lqPDBi2FRxoAX/c/Z5huRzelKyY+tkGWv6bb/+RBrWlXEBmx/64pgB4Djtke2ns+IPJaG8P8CHh5+aGi5FXV38Cna6rYF9YKGD/uuXPZ9IjbcFKXsgQgf/6dZ3Kt27LOjFlKico6i68vL1rxqTGvyYNAYe6CWRbuj6pK6411ZWoTDc+ieYeeUIIZjoTnkX/Vz6Lm+x7x3Q9i0WvvNBqerPMrmtrjddf9zzMcOL+VEm0FRIE3yv0X0kC2wjqrUARIIaaRdz6v0akeMLojgG+wpOar80HMOxMcI10c/KCyIa3zL8mCjvNXC1kUvhurEvZuh0eWYPNmOCWQDJEyiXSNXyvpukNX7gD8CzA0vyUCrcU6IpZa3iiPwI/JPyWOdoISqwKDRWu2EzeUAwbwSCy1EBYITSH4czMMLMi/WI3s8rA+NsdnhAD6pdWog5pEB+nefoKwYKq5WpMtxydQENXNImU+XGSnro=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b773f310-47e8-49bd-eff7-08d8fdb9299f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 13:44:58.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3wAIOKtGFtpUcpG/AHicEg5EBxSAvuew9uCAY+R9Wo9WZ/2LpJVO9iztw14OlxTZUVzo2Op3v6hlsxss1XVY+V9FuFqyCfskJ9T73yx40M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2703
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> On Mon, Apr 12, 2021 at 03:43:27PM +0300, Emmanuel Grumbach wrote:
> > iwlmei is a driver that handles the communication with the Wireless
> > driver of the CSME firmware.
> > More details in the documentation included in this patch.
> >
> > Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/Kconfig    |   13 +
> >  drivers/net/wireless/intel/iwlwifi/Makefile   |    2 +
> >  .../net/wireless/intel/iwlwifi/mei/Makefile   |    8 +
> >  .../net/wireless/intel/iwlwifi/mei/internal.h |   20 +
> >  .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  440 ++++
> > drivers/net/wireless/intel/iwlwifi/mei/main.c | 2026 +++++++++++++++++
> > drivers/net/wireless/intel/iwlwifi/mei/net.c  |  409 ++++
> > drivers/net/wireless/intel/iwlwifi/mei/sap.h  |  736 ++++++
> >  .../wireless/intel/iwlwifi/mei/trace-data.h   |   69 +
> >  .../net/wireless/intel/iwlwifi/mei/trace.c    |   15 +
> >  .../net/wireless/intel/iwlwifi/mei/trace.h    |   62 +
> >  11 files changed, 3800 insertions(+)
> >  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/Makefile
> >  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/internal.h
> >  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
> >  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/main.c
> >  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/net.c
> >  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/sap.h
> >  create mode 100644
> > drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
> >  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.c
> >  create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.h
> >
> > diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig
> > b/drivers/net/wireless/intel/iwlwifi/Kconfig
> > index 1085afbefba8..eb68f93bbe90 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> > @@ -92,6 +92,19 @@ config IWLWIFI_BCAST_FILTERING
> >  	  If unsure, don't enable this option, as some programs might
> >  	  expect incoming broadcasts for their normal operations.
> >
> > +config IWLMEI
> > +	tristate "Enable V-PRO for WLAN"
> > +	depends on INTEL_MEI
> > +	depends on IWLMVM
> > +	help
> > +	  Enable V-PRO. This allows to communicate with the CSME firmware.
> > +	  This is supported starting from Tiger Lake platforms and has been
> > +	  tested on 9260 devices only. Enabling this option on a platform tha=
t
> > +	  has a different device and has Wireless enabled on AMT can
> prevent
> > +	  WiFi from working correctly.
>=20
> What does any of that mean?  I can't understand it at all, and here I tho=
ught I
> understand new hardware terms :(
>=20
> > +
> > +	  If unsure, say N.
>=20
> module name?
>=20
>=20
> > +
> >  menu "Debugging Options"
> >
> >  config IWLWIFI_DEBUG
> > diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile
> > b/drivers/net/wireless/intel/iwlwifi/Makefile
> > index 14b0db28143b..ff4d4b651c3e 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/Makefile
> > +++ b/drivers/net/wireless/intel/iwlwifi/Makefile
> > @@ -30,4 +30,6 @@ ccflags-y +=3D -I$(src)
> >  obj-$(CONFIG_IWLDVM)	+=3D dvm/
> >  obj-$(CONFIG_IWLMVM)	+=3D mvm/
> >
> > +obj-$(CONFIG_IWLMEI)	+=3D mei/
>=20
> Cuddle up against the line above?
>=20
> > --- /dev/null
> > +++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
> > @@ -0,0 +1,2026 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>=20
> I didn't think that Intel was doing dual-license for .c files in the kern=
el,
> especially for ones that call GPL-only kernel symbols :(
>=20
> The "loonacy" of doing this for .h files kind of makes sense if you reall=
y
> squint, but even then, it's crazy.  But for .c files like this, that's no=
t good.
>=20
> You all have the right to license the code under whatever you want, so wh=
y
> keep a BSD license on it when it goes into the kernel tree?
>=20
> In the past, I have been told by various Intel lawyers/legal-types that t=
hey
> were not going to do this anymore.  I know things change, but are you sur=
e
> that this is ok with the current corporate position of Linux kernel code =
that
> calls other parts of the core kernel like this?
>=20
> Same for all new files in this patchset.
>=20
>=20
> > +/*
> > + * Copyright (C) 2021 Intel Corporation  */
> > +
> > +#include <linux/etherdevice.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/rtnetlink.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/mei_cl_bus.h>
> > +#include <linux/rcupdate.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/skbuff.h>
> > +#include <linux/wait.h>
> > +#include <linux/slab.h>
> > +#include <linux/mm.h>
> > +
> > +#include "internal.h"
> > +#include "iwl-mei.h"
> > +#include "trace.h"
> > +#include "trace-data.h"
> > +#include "sap.h"
> > +
> > +MODULE_DESCRIPTION("The Intel(R) wireless / CSME firmware
> > +interface"); MODULE_LICENSE("GPL");
> > +
> > +#define CHECK_FOR_NEWLINE(f) BUILD_BUG_ON(f[sizeof(f) - 2] !=3D '\n')
> > +
> > +#define IWL_MEI_DEBUG(c, f, a...)		\
> > +	do {					\
> > +		CHECK_FOR_NEWLINE(f);		\
>=20
> Huh?
>=20
> > +		dev_dbg(&(c)->dev, f, ## a);	\
>=20
> Just use dev_dbg(), don't be special for a single driver, it hurts when t=
rying to
> read different drivers.

I took this from iwlwifi. I can change if needed, not a big deal.

>=20
>=20
> > +	} while (0)
> > +
> > +#define IWL_MEI_INFO(c, f, a...)		\
> > +	do {					\
> > +		CHECK_FOR_NEWLINE(f);		\
> > +		dev_info(&(c)->dev, f, ## a);	\
> > +	} while (0)
> > +
> > +#define IWL_MEI_ERR(c, f, a...)			\
> > +	do {					\
> > +		CHECK_FOR_NEWLINE(f);		\
> > +		dev_err(&(c)->dev, f, ## a);	\
> > +	} while (0)
>=20
> Same for all of the above, just use dev_info() and dev_err() please.

Sure
>=20
> > +
> > +#define MEI_WLAN_UUID UUID_LE(0x13280904, 0x7792, 0x4fcb, \
> > +			      0xa1, 0xaa, 0x5e, 0x70, 0xcb, 0xb1, 0xe8, 0x65)
> > +
> > +/*
> > + * Since iwlwifi calls iwlmei without any context, hold a pointer to
> > +the
> > + * mei_cl_device structure here.
> > + * Define a mutex that will synchronize all the flows between iwlwifi
> > +and
> > + * iwlmei.
> > + */
> > +static struct mei_cl_device *iwl_mei_global_cldev; static
> > +DEFINE_MUTEX(iwl_mei_mutex); static unsigned long iwl_mei_status; #if
> > +IS_ENABLED(CONFIG_DEBUG_FS) static bool defer_start_message;
> > +
> > +module_param_named(defer_start_message, defer_start_message,
> bool,
> > +0644); MODULE_PARM_DESC(defer_start_message,
> > +		 "Defer the start message Tx to CSME (default false)");
>=20
> Why do you need this?  Who is going to set it to anything else, and why
> would they?  This isn't the 1990's anymore, please do not add new module
> parameters.

For testing. I need this to be able to force a certain order of initializat=
ion which is possible (and hence must be tested) but not likely to happen.
Another point is tracing. This allows me to load the module but prevent any=
 real operation. Then, start tracing. This way, I can see the whole flow in=
 tracing, even the very beginning.

>=20
>=20
> > +#endif
> > +
> > +enum iwl_mei_status_bits {
> > +	IWL_MEI_STATUS_SAP_CONNECTED,
> > +};
> > +
> > +bool iwl_mei_is_connected(void)
> > +{
> > +	return test_bit(IWL_MEI_STATUS_SAP_CONNECTED,
> &iwl_mei_status); }
> > +EXPORT_SYMBOL(iwl_mei_is_connected);
>=20
> EXPORT_SYMBOL_GPL()?  I have to ask... :)
>=20
>=20
> > +struct iwl_mei {
> > +	wait_queue_head_t get_nvm_wq;
> > +	struct work_struct send_csa_msg_wk;
> > +	wait_queue_head_t get_ownership_wq;
> > +	struct iwl_mei_shared_mem_ptrs shared_mem;
> > +	struct mei_cl_device *cldev;
> > +	struct iwl_mei_nvm *nvm;
> > +	struct iwl_mei_filters __rcu *filters;
> > +	bool got_ownership;
> > +	bool amt_enabled;
> > +	bool csa_throttled;
> > +	bool csme_taking_ownership;
> > +	struct delayed_work csa_throttle_end_wk;
> > +	spinlock_t data_q_lock;
> > +
> > +	atomic_t sap_seq_no;
> > +	atomic_t seq_no;
> > +
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +	struct dentry *dbgfs_dir;
> > +	wait_queue_head_t debugfs_wq;
> > +	bool ping_pending;
> > +#endif
>=20
> Why #ifdef?  Does the size really matter?

Size. I can drop those.

>=20
> > +static ssize_t iwl_mei_write_cyclic_buf(struct mei_cl_device *cldev,
> > +					struct iwl_sap_q_ctrl_blk *notif_q,
> > +					u8 *q_head,
> > +					const struct iwl_sap_hdr *hdr)
> > +{
> > +	u32 rd =3D le32_to_cpu(READ_ONCE(notif_q->rd_ptr));
> > +	u32 wr =3D le32_to_cpu(READ_ONCE(notif_q->wr_ptr));
> > +	u32 q_sz =3D le32_to_cpu(notif_q->size);
> > +	size_t room_in_buf;
> > +	size_t tx_sz =3D sizeof(*hdr) + le16_to_cpu(hdr->len);
> > +
> > +	if (WARN_ON(rd > q_sz || wr > q_sz))
> > +		return -EINVAL;
>=20
> If any of the WARN_ON() things in this driver can ever trigger, just hand=
le
> them normally and do NOT call WARN_ON() as you just rebooted the box for
> a simple thing that you could have recovered from.

My understanding is that WARN_ON does not reboot the box which is why it wa=
s invented when we already had BUG_ON. This can't be triggered by the user =
space, but can be triggered by the CSME firmware that runs on the chipset.

>=20
> Some of these WARN_ON() in the code feel very lazy as you control the
> caller so you "know" that this will never happen.  So don't leave them in=
, it's
> debugging code that you can now remove.

I can transform them in error prints, but again, my understanding is / was =
that WARN_ON is ok to use and won't reboot the box since it differs from BU=
G_ON.

>=20
> > +
> > +	room_in_buf =3D wr >=3D rd ? q_sz - wr + rd : rd - wr;
> > +
> > +	/* we don't have enough room for the data to write */
> > +	if (WARN_ON(room_in_buf < tx_sz))
> > +		return -ENOSPC;
>=20
> Can userspace trigger this?  If so, again, you just crashed the machine w=
hen
> panic_on_warn is enabled.
>=20
> Just do a real check and handle the issue.

I'll change to a simple print.

>=20
> > +static void
> > +iwl_mei_handle_rx_start_ok(struct mei_cl_device *cldev,
> > +			   const struct iwl_sap_me_msg_start_ok *rsp,
> > +			   ssize_t len)
> > +{
> > +	struct iwl_mei *mei =3D mei_cldev_get_drvdata(cldev);
> > +
> > +	if (len !=3D sizeof(*rsp)) {
> > +		IWL_MEI_ERR(cldev,
> > +			    "got invalid SAP_ME_MSG_START_OK from CSME
> firmware\n");
> > +		IWL_MEI_ERR(cldev,
> > +			    "size is incorrect: %ld instead of %lu\n",
> > +			    len, sizeof(*rsp));
> > +		return;
> > +	}
> > +
> > +	if (rsp->supported_version !=3D SAP_VERSION) {
> > +		IWL_MEI_ERR(cldev,
> > +			    "didn't get the expected version: got %d\n",
> > +			    rsp->supported_version);
> > +		return;
> > +	}
> > +
> > +	IWL_MEI_INFO(cldev,
> > +		     "Got a valid SAP_ME_MSG_START_OK from CSME
> firmware\n");
>=20
> When drivers work properly, they are quiet.  This is very noisy, please
> remove debugging code like this.

I'll move to dbg level.

>=20
> > +
> > +	mutex_lock(&iwl_mei_mutex);
> > +	set_bit(IWL_MEI_STATUS_SAP_CONNECTED, &iwl_mei_status);
> > +	/* wifi driver has registered already */
> > +	if (iwl_mei_cache.ops) {
> > +		WARN_ON(iwl_mei_send_sap_msg(mei->cldev,
> > +					     SAP_MSG_NOTIF_WIFIDR_UP));
>=20
> Why????

Same explanation as above.

>=20
> > +		iwl_mei_cache.ops->sap_connected(iwl_mei_cache.priv);
> > +	}
> > +
> > +	mutex_unlock(&iwl_mei_mutex);
> > +}
> > +
> > +static void iwl_mei_handle_csme_filters(struct mei_cl_device *cldev,
> > +					const struct iwl_sap_csme_filters
> *filters) {
> > +	struct iwl_mei *mei =3D
> mei_cldev_get_drvdata(iwl_mei_global_cldev);
> > +	struct iwl_mei_filters *new_filters;
> > +	struct iwl_mei_filters *old_filters;
> > +
> > +	IWL_MEI_DEBUG(cldev, "Got CSME filters\n");
>=20
> ftrace is your friend, remove these pointless "the code got here!"
> lines.  You have loads of them...

This is debug. Won't appear unless you want it.
I have extensive tracing support.

>=20
> > +static void iwl_mei_handle_rx_host_own_req(struct mei_cl_device
> *cldev,
> > +					   const struct iwl_sap_msg_dw *dw)
> {
> > +	struct iwl_mei *mei =3D mei_cldev_get_drvdata(cldev);
> > +
> > +	IWL_MEI_DEBUG(cldev, "Got ownership req response: %d\n", dw-
> >val);
>=20
> Code got here!  :(

Same, this is protected by a dynamic debug knob.
I can see tons of those in mei bus driver .
$ git grep _dbg\( -- drivers/misc/mei | wc -l
228

>=20
> > +
> > +	if (!dw->val) {
> > +		IWL_MEI_INFO(cldev, "Ownership req denied\n");
>=20
> why?????
>=20
> > +		return;
>=20
> No error returned?

This is not an error. This means that the CSME firmware is not allowing the=
 host to use the WLAN device.

>=20
> > +	}
> > +
> > +	mei->got_ownership =3D true;
> > +	wake_up_all(&mei->get_ownership_wq);
> > +
> > +	iwl_mei_send_sap_msg(cldev,
> > +
> SAP_MSG_NOTIF_HOST_OWNERSHIP_CONFIRMED);
> > +
> > +	/* We can now start the connection, unblock rfkill */
> > +	if (iwl_mei_cache.ops)
> > +		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false); }
> > +
> > +static void iwl_mei_handle_pong(struct mei_cl_device *cldev,
> > +				const void *payload)
> > +{
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +	struct iwl_mei *mei =3D mei_cldev_get_drvdata(cldev);
> > +
> > +	mei->ping_pending =3D false;
> > +	wake_up_interruptible_all(&mei->debugfs_wq);
> > +#endif
>=20
> Why is this dependant on debugfs?

Because only debugfs can trigger the flow that would be waiting for the pon=
g.
I can remove this debugfs know if you like.

>=20
> > +
> > +	IWL_MEI_DEBUG(cldev, "Got PONG\n");
>=20
> again, ftrace.
>=20
> > +static void iwl_mei_handle_sap_data(struct mei_cl_device *cldev,
> > +				    const u8 *q_head, u32 q_sz,
> > +				    u32 rd, u32 wr, ssize_t valid_rx_sz,
> > +				    struct sk_buff_head *tx_skbs) {
> > +	struct iwl_sap_hdr hdr;
> > +	struct net_device *netdev =3D
> > +		rcu_dereference_protected(iwl_mei_cache.netdev,
> > +
> lockdep_is_held(&iwl_mei_mutex));
> > +
> > +	if (!netdev) {
> > +		IWL_MEI_INFO(cldev, "No netdevice, dropping the Tx
> packet\n");
>=20
> quiet!!!

This is actually not a usual path. A race is happening here...

>=20
> Or at the least, make this an error so that a user can handle it properly=
.  They
> can do something about this, right?  If not, why did you just tell them t=
his
> happened?

There isn't much I can do here. The CSME firmware is sending a packet to iw=
lmei to send on the WLAN link, but the link isn't valid anymore.

>=20
> > +		return;
>=20
> No error value?

Nobody will read this error value. This is a handler for a notification fro=
m the CSME firmware.

>=20
> > +	}
> > +
> > +	while (valid_rx_sz >=3D sizeof(hdr)) {
> > +		struct ethhdr *ethhdr;
> > +		unsigned char *data;
> > +		struct sk_buff *skb;
> > +		u16 len;
> > +
> > +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, &hdr,
> sizeof(hdr));
> > +		valid_rx_sz -=3D sizeof(hdr);
> > +		len =3D le16_to_cpu(hdr.len);
> > +
> > +		if (valid_rx_sz < len) {
> > +			IWL_MEI_ERR(cldev,
> > +				    "Data queue is corrupted: valid data len
> %ld, len %d\n",
> > +				    valid_rx_sz, len);
>=20
> What can be done if this happens?
I guess I can restart the whole handshake with the CSME firmware. I haven't=
 implemented this flow (yet).

>=20
> > +			break;
> > +		}
> > +
> > +		if (len < sizeof(*ethhdr)) {
> > +			IWL_MEI_ERR(cldev,
> > +				    "Data len is smaller than an ethernet
> header? len =3D %d\n",
> > +				    len);
> > +		}
> > +
> > +		valid_rx_sz -=3D len;
> > +
> > +		if (le16_to_cpu(hdr.type) !=3D SAP_MSG_DATA_PACKET) {
> > +			IWL_MEI_INFO(cldev, "Unsupported message: type
> %d, len %d\n",
> > +				     le16_to_cpu(hdr.type), len);
>=20
> So userspace can spam the kernel log?

This is not userspace, this is the CSME firmware.

>=20
> Please revisit _ALL_ of your messages you are printing out here, it feels=
 way
> way way too noisy, like you got the code up and working with the debug li=
nes
> in it and forgot to remove it.

[   12.665966] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Go=
t a valid SAP_ME_MSG_START_OK from CSME firmware

That's the only line I am printing by default. I can remove it. I can't do =
better than 0 printing.

>=20
> How did this get missed in the internal Intel reviews that of course was
> required to happen before sending it to others outside of the firewall to
> review?
>=20
> > +			continue;
> > +		}
> > +
> > +		/* We need enough room for the WiFi header + SNAP + IV */
> > +		skb =3D netdev_alloc_skb(netdev, len + 26 + 8 + 8);
> > +
> > +		skb_reserve(skb, 26 + 8 + 8);
> > +		ethhdr =3D skb_push(skb, sizeof(*ethhdr));
> > +
> > +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr,
> > +				    ethhdr, sizeof(*ethhdr));
> > +		len -=3D sizeof(*ethhdr);
> > +
> > +		skb_reset_mac_header(skb);
> > +		skb_reset_network_header(skb);
> > +		skb->protocol =3D ethhdr->h_proto;
> > +
> > +		/* we don't really want to get anything besides 802.3 packets
> */
> > +		WARN_ON_ONCE(!eth_proto_is_802_3(ethhdr->h_proto));
> > +
> > +		data =3D skb_put(skb, len);
> > +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, data, len);
> > +
> > +		/*
> > +		 * Enqueue the skb here so that it can be sent later when we
> > +		 * do not hold the mutex. TX'ing a packet with a mutex held is
> > +		 * possible, but it wouldn't be nice to forbid the TX path to
> > +		 * call any of iwlmei's functions, since every API from iwlmei
> > +		 * needs the mutex.
> > +		 */
> > +		__skb_queue_tail(tx_skbs, skb);
> > +	}
> > +}
> > +
> > +static void iwl_mei_handle_sap_rx_cmd(struct mei_cl_device *cldev,
> > +				      const u8 *q_head, u32 q_sz,
> > +				      u32 rd, u32 wr, ssize_t valid_rx_sz) {
> > +	struct page *p =3D alloc_page(GFP_KERNEL);
> > +	struct iwl_sap_hdr *hdr;
> > +
> > +	if (!p)
> > +		return;
> > +
> > +	hdr =3D page_address(p);
> > +
> > +	while (valid_rx_sz >=3D sizeof(*hdr)) {
> > +		u16 len;
> > +
> > +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, hdr,
> sizeof(*hdr));
> > +		valid_rx_sz -=3D sizeof(*hdr);
> > +		len =3D le16_to_cpu(hdr->len);
> > +
> > +		if (valid_rx_sz < len)
> > +			break;
> > +
> > +		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, hdr + 1, len);
> > +
> > +		trace_iwlmei_sap_cmd(hdr, false);
> > +		iwl_mei_handle_sap_msg(cldev, hdr);
> > +		valid_rx_sz -=3D len;
> > +	}
> > +
> > +	/* valid_rx_sz must be 0 now... */
> > +	WARN_ON_ONCE(valid_rx_sz);
>=20
> reboot!
>=20
> {sigh}
>=20
> <snip>
>=20
> > +static void iwl_mei_dbgfs_register(struct iwl_mei *mei) {
> > +	mei->dbgfs_dir =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
>=20
> At the root of debugfs, bold move :)

There is no other place since the mei bus doesn't provide another dir to ho=
ok on.

>=20
> > +
> > +	if (!mei->dbgfs_dir)
> > +		return;
>=20
> Why check this?  Just feed the result back into other debugfs_create() ca=
lls,
> no need to care.
>=20
> And why save the directory name at all, can't you just look it up when yo=
u
> want to remove it anyway?

Possible.

>=20
> > +
> > +	init_waitqueue_head(&mei->debugfs_wq);
> > +
> > +	debugfs_create_ulong("status", S_IRUSR,
> > +			     mei->dbgfs_dir, &iwl_mei_status);
> > +	debugfs_create_file("ping", S_IRUSR, mei->dbgfs_dir,
> > +			    mei, &iwl_mei_dbgfs_ping_ops);
> > +	debugfs_create_file("send_start_message", S_IWUSR, mei-
> >dbgfs_dir,
> > +			    mei, &iwl_mei_dbgfs_send_start_message_ops);
> > +	debugfs_create_file("req_ownserhip", S_IWUSR, mei->dbgfs_dir,
> > +			    mei, &iwl_mei_dbgfs_req_ownership_ops);
> > +}
> > +
> > +static void iwl_mei_dbgfs_unregister(struct iwl_mei *mei) {
> > +	debugfs_remove_recursive(mei->dbgfs_dir);
> > +	mei->dbgfs_dir =3D NULL;
>=20
> Why set this to NULL?

I can remove.

>=20
> > +}
> > +
> > +#else
> > +
> > +static void iwl_mei_dbgfs_register(struct iwl_mei *mei) {} static
> > +void iwl_mei_dbgfs_unregister(struct iwl_mei *mei) {}
>=20
> This type of thing goes in a .h file, you know better.

A header file only for less a handful of functions?

>=20
>=20
> > +
> > +#endif /* CONFIG_DEBUG_FS */
> > +
> > +/**
> > + * iwl_mei_probe - the probe function called by the mei bus
> > +enumeration
> > + *
> > + * This allocates the data needed by iwlmei and sets a pointer to
> > +this data
> > + * into the mei_cl_device's drvdata.
> > + * It starts the SAP protocol by sending the SAP_ME_MSG_START without
> > + * waiting for the answer. The answer will be caught later by the Rx
> callback.
> > + */
> > +static int iwl_mei_probe(struct mei_cl_device *cldev,
> > +			 const struct mei_cl_device_id *id) {
> > +	struct iwl_mei *mei;
> > +	int ret;
> > +
> > +	mei =3D devm_kzalloc(&cldev->dev, sizeof(*mei), GFP_KERNEL);
> > +	if (!mei)
> > +		return -ENOMEM;
> > +
> > +	init_waitqueue_head(&mei->get_nvm_wq);
> > +	INIT_WORK(&mei->send_csa_msg_wk,
> iwl_mei_send_csa_msg_wk);
> > +	INIT_DELAYED_WORK(&mei->csa_throttle_end_wk,
> > +			  iwl_mei_csa_throttle_end_wk);
> > +	init_waitqueue_head(&mei->get_ownership_wq);
> > +	spin_lock_init(&mei->data_q_lock);
> > +
> > +	mei_cldev_set_drvdata(cldev, mei);
> > +	mei->cldev =3D cldev;
> > +
> > +	ret =3D iwl_mei_alloc_shared_mem(cldev);
> > +	if (ret)
> > +		goto free;
> > +
> > +	iwl_mei_init_shared_mem(mei);
> > +
> > +	ret =3D iwl_mei_enable(cldev);
> > +	if (ret)
> > +		goto free_shared_mem;
> > +
> > +	iwl_mei_dbgfs_register(mei);
> > +
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
>=20
> #if should not be in .c files, again, you all know better...
>=20
> I'm giving up here, sorry, I can't do it anymore...
>=20
> greg k-h
