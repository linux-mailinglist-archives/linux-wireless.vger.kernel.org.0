Return-Path: <linux-wireless+bounces-31578-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ1gFDpRhGkp2gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31578-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:13:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C903BEFC3F
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32445300678C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A34835F8B6;
	Thu,  5 Feb 2026 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmb1jDTi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BE348445;
	Thu,  5 Feb 2026 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279224; cv=fail; b=EZrVojRe6cBC+QGbuwwiKPiEstADk6jwx/leJYB2gbibs9VvcYkY/4lbmy+Z/f2qGjJfBnxKNFHgjTSSkT/AfsAM8bysSVOKzrGkcX4AtT0sx2vCT1m00AXf8MTLztQeDiE3WWGRCVoYYPCP/FYy00LcZkKJJ+aYXn6V7uBs83c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279224; c=relaxed/simple;
	bh=WJuMBeFDouRMBau5BByZjQs1WlJMtA82ltAKxDVX0+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftmoRx3HX+BM0J/8Ioz4wrRVyt2U6guFUNUvycqE2JrM1/MFKn0obku28xvaUMozFpUDnfTR/V0VGVnRKgFphkkdUW27eLSclyyJN0CqCSzoXFXiohSEZeevfBykigKrWxqKnjxCtRqLenPIqYp7oFagcjR+Mjck0RCutktO6IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmb1jDTi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770279223; x=1801815223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WJuMBeFDouRMBau5BByZjQs1WlJMtA82ltAKxDVX0+8=;
  b=dmb1jDTiKjwnLqcmpBKaux1yqfqCBWPmHUQNItb4wMmg942crVRDqM3h
   EuvCktTIak2qModmTOuNnRHGk71rQHm7fkm7V4YaFINJt6qleCrJo/Pek
   XIfSYchb0oWPHDv2OWMR2wNEjCT3xLAilo0SsyJz7DjUv9CrK98ahV+Cg
   qYId+OLn2p0daFECGIhusvXRgL8e66b0XHTtanUE+fp9JUToxgx74+HE/
   K6OBhR3TJKB8+hbGPRGUtAN0bU24X5femjD7nHC7WyZbrW/LKvNBSNmSR
   9/IqJZAISCrClra3JFme9i3+Eppt5l9fX2bROWZyNzIeRnTBaFu8WX1qN
   g==;
X-CSE-ConnectionGUID: K/TofG0lTmuLN/d4VXT08Q==
X-CSE-MsgGUID: q6Wvb225TH2rsgYPhdtzxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88894619"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="88894619"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:13:43 -0800
X-CSE-ConnectionGUID: KpbvzUo9S+qe6x3gWuXCkg==
X-CSE-MsgGUID: +WjVpUA5Q5+eHwnskXiqKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="214955866"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:13:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:13:42 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 00:13:42 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:13:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV+iiWVX7Az2Sud1WFXvVN4mE6my5j+dFCRnYukqrWE7xF//ftPUtRDKPE4akhv+t+CSboNJRTOdG0UYW0Wcb1UI4IJdSW5DIW/Jw9IqFf9N/k4d7MQlr5x/VQPvBVi+7kYa1Jn9vopxrQF0nLrd2w3Kb2qAPREw3PlpOIpFvbs5UL8nEobQCYRt7nUZ4oI6zhpKwnECsbtOeIrqbfQve0D7R3eVYZCSLVtBRjA++obJe2nlYuWtz9m+C4/PpKJcjJsFYCJr4WgVKbcgADw3gzjUmMwFPS2QOZ+a2RcmCvO3Bx5rlI/JKDsJ0JaeplysWtdz11YACwX9ncp7nL0wjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ouHPfMf4JQRIhs+0N1DQjQSZpBrNnkggxKl8Q4s0PA=;
 b=bwkLc8UqR0noauYRq82R3pbnYeQqK8/rtJwirWRhdBZxl7skhDLZTkO2KODfFrvolwL7B2P4ooGdHHMLmtmfwlqecwC7kGJ77A7ScvIIgjriYCelGR0hxEImRov1OG2CF/65olLGLmdap0E5rgNRVK4eNAjRl0f/A8Ap2rnf/7TuIaew4NhoUqZxG5FBJsSL56gL7nFaHk5pi2NucPM1jNpNbxewoiThNhOTmaNyyxVp4AWbGUQNiJsei4zuoYYDpHr+AtsX7Nx0FQBRcgcL2lsP5Ljm9LU2E2WIHGU+Tzn7zPCP1qB2cEqNrjdyxMIBMNlfI/Pfl5WTL2mHN9RKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8699.namprd11.prod.outlook.com (2603:10b6:408:1ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 08:13:39 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 08:13:39 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>, "Alice
 Michael" <alice.michael@intel.com>
Subject: RE: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
Thread-Topic: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
Thread-Index: AQHclnTCGHK9IvvOO0WamlZBgXRFZLVzwCQw
Date: Thu, 5 Feb 2026 08:13:39 +0000
Message-ID: <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260205075445.43347-1-enelsonmoore@gmail.com>
In-Reply-To: <20260205075445.43347-1-enelsonmoore@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8699:EE_
x-ms-office365-filtering-correlation-id: c424535c-5518-4f56-e3fd-08de648e7817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?arGL0GQ93eROyt6TIECSq7spnNCXDoTpuMqJg4HUfmm5r9gtG88nrmebYSmz?=
 =?us-ascii?Q?vWyHS84Mo4k4XuR/4H5IqB873hlXjNpcjU/qwO6rNH7NRRHfASyOyZANeSlO?=
 =?us-ascii?Q?khaiNi53WFfOpl7CBILlS0VAjtXw0N0lGO7rWhwUkdZ9kyxGLWlm3aZKsskG?=
 =?us-ascii?Q?kxFCRdG8FMH69COwbrJLbb8W+BBtQODu4F614zy8YitQUPT4Nbi2fo2zEDIb?=
 =?us-ascii?Q?4Np8dtgBI8DRm5Gf3Jzn+AnkNLOPkk+DAagLDmXZZTtGOAJmTV8fqTi2PJPk?=
 =?us-ascii?Q?m5TMqge6x3VWdJPQEafXugpeJJ7jRImlprxPemUSDFIu/XKaorrWbvcjt7oH?=
 =?us-ascii?Q?Dg2AhhWom8OhN8A6PhpMaAi2JWTW2LwHcJ+IV8BeCUDRWks/I8815v6VJZDM?=
 =?us-ascii?Q?9pdZ7Pav5VEsXSQ2pO+x72Js7fJalOUfmKF+ZyHXNyPHP9edsBsmo0H4hEjG?=
 =?us-ascii?Q?O3bZL2QysAjKHZyA2x61lH/OBh4R3Q1Lo02EqCRmjAcigWlt0lk+YQSEQVS2?=
 =?us-ascii?Q?hSh3ctdE78STSDYFJO323vjkild9ryHLklvADgAIDwr5utonIWxca9au0SV8?=
 =?us-ascii?Q?BSAhH//T3SEtLDbT7AVeRY7BsVn9k2+rMWb1enggiR+A7NKhS7WdIK5s/9wA?=
 =?us-ascii?Q?wVekRmdt72CSY4LTRU9YehxF1MbNcGqQe4aN4g7vKQKz0JiR3DV1pI9PuZlD?=
 =?us-ascii?Q?rORGLi5EcUMtV9YgeWvSHoRp5qY2yr/OJuNWIpPW1ujzYSnA002EWckLERSV?=
 =?us-ascii?Q?tFht6xtGOcFxGe/hqcI43mPQlNqd3O+sNnhSnYo1p0WNRFLxyTL1rOpq29jE?=
 =?us-ascii?Q?yGWkVk77I16ao2e+IIaSFOIOcPKzBpwQ/oOFphjoCc0v0BAKBiGGF3B93Cas?=
 =?us-ascii?Q?o8GQExbE1Y02Hb1w5NmeIrkfHb5SPW1JvjEXpSgdgBaMzKiySR4sz4xb0tg2?=
 =?us-ascii?Q?THjjmoZn+Y3w++9bc3LujSjOa7y65mTdl9inBMnvVN/wiCE7tTFCf9ZAFgKQ?=
 =?us-ascii?Q?eKEq4REDixly8tBQ3W0Owqyd5FinLl1/bXjkNCtwrvd7+LHj5sOVwbXOHUtQ?=
 =?us-ascii?Q?tgMynbXitNi1nYApY4t70QPFMujha5R8SFzzxNKL4UCONWbNvMB5o2A8KwU4?=
 =?us-ascii?Q?vlRpohsSz3t/4FaphRJ0JMu6l6VyktSXW8J5uN2y0ykqG3v4W2I8Pse2aCW4?=
 =?us-ascii?Q?jq1zMziFJApJcHYsf1vKCFO4L5ZZifSUzW5VdWp0+ZN4e/EDAY5FtpccpIOT?=
 =?us-ascii?Q?ludCWqq9WTlqLEka8zlryO6aiX0OwYktLaNN0OdLNngMPIlxYqmwVIaMFQ6Y?=
 =?us-ascii?Q?4M2y0jytHHXdrcDonxrECox2gkX6T70z3LwUzWdKzcMYcMYgaVBJYbU6uJeD?=
 =?us-ascii?Q?9nXYHH0HxVZ16Hxub8M2RUzLW8i/GE8vCnu9IiuMk66MycIsgpKm569CpSbj?=
 =?us-ascii?Q?iir1RxXTYtIgKGbgb3dqTkf39z7VJXiMLGsu4V+KO2zXJYveWNT61waVCWbZ?=
 =?us-ascii?Q?DEldGMD/3zrlZ3Bn+PR4SRjQ7iRwpFCL/fNUxElRXEeO9ASREdkOsAj5cfEq?=
 =?us-ascii?Q?v/U/r5biIfoueQO/VdF9EZoF/HEXFwM3m6T5voZxdXiObvH2LA2jBKzLw+eg?=
 =?us-ascii?Q?SkxtkiOxpOVosamomDGjO+c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o6IL6ydrSrsUjwYc2Soy0hA/HL3YasD/JTKGus/Y7TSpLttyd/NoCkPR+ZM2?=
 =?us-ascii?Q?qzrwjfZ6zBlAdoJ7A+8fJ5l3UFUiZET1jtMvMWdAUx53btBxGAX100H2RP/l?=
 =?us-ascii?Q?5xO9eOBM3c4q0B27YGY2LqU7MlX34Xo4kAOtQRN39uj7VVdhImrl1+OK04OG?=
 =?us-ascii?Q?QAh+vt/L94XpxmQLwC1aSP1K1ALIV6175tSglVUc2YhOI0bZXNjV9uR3HOdS?=
 =?us-ascii?Q?36G1ZsRJzcM9wgsU2eCwakG7eI0BNpy+qIoeDD5flWqrueE/KwAd3ftbwf+V?=
 =?us-ascii?Q?Cwg6l7gYGH5VaTHjudZpCkqhNy9XisW8+TzUbr3G4kn3gKXhRVtsCLTBJ7gm?=
 =?us-ascii?Q?h8fz7pg22Ww6psPxzTOBB5d5eK8eN8u3qSA6sDR18ppXsQtXhNBuFD0sk4+l?=
 =?us-ascii?Q?8rWCnE98RzX5MCbbQa6gzww+eCA4nxso0AifNXfP1QZKOhNsLyKoXOo/dzWk?=
 =?us-ascii?Q?I0VWwHFrOFVYvWXF1nge9ktWAlJjM8BmE+dCUYUT/5HZ2rSYtE+FRuhDUdQB?=
 =?us-ascii?Q?GMOFaqgrocgcJw44vd6SEbatMBPmFFyvP1ZHqGf/AQrbkwf9qsI8DXnA/wua?=
 =?us-ascii?Q?Aol7WYdvyPZFDLw7a5SI1Gus2/72UO7fmEQxhhkt4hZdoQYZ3atAVr0vs6xc?=
 =?us-ascii?Q?GRu1TuiIrJhdOvoMw+X+aqYZBio8v2929QBjw+qO29NO9NM9uEHZSTu2zKaD?=
 =?us-ascii?Q?y0wFuyTdCKdkaKiz08nOdkxyBZLqcZkoV03J1OWERCO7Uiv4itzP5fD/m3aD?=
 =?us-ascii?Q?WIoHo0QsZsdRs5eGOOpij88luZiYCJ54bmElu/zIWjnKXz8Z2qe3JvFUphRD?=
 =?us-ascii?Q?bQMrK5/Nvd8EB/h01jrFfDkvcnYn1I/52jKOdsSqAvH8Uav4d1GO9xmbK8w8?=
 =?us-ascii?Q?LAa3mN9skCTZLGcETe4xCqtaC5pk66pT9rogFF1AXPnkjFA+EDjEJkNE201w?=
 =?us-ascii?Q?2HAp/HX65c0XDjfi6WC4V08V5A1ENWsoNKfOQ8HoZqvzsdQ5NMrpTi285Bhp?=
 =?us-ascii?Q?nGxWnAwzlaS/99QKvEEkq6XUaQ1t0kHD1ccg8MKXWplYWRUcFjfKkfb3SSzC?=
 =?us-ascii?Q?wGsfhQsy/5gHy9F/+oBF3VRAunL/A7h6qwBpIkiOqTOY2oCN4s5LHHmCLopp?=
 =?us-ascii?Q?3nTYVrO13wFPW5vzrEZPp9gGi1A0ERoTFB5iNm9+fuF1gVk5PJcsapL5+Br/?=
 =?us-ascii?Q?gwbdWG3uixLobCVVu0he6IyULF9KmsCNI+IO65MSDHibcZwBx2wuCVBbwZWn?=
 =?us-ascii?Q?aplKEOcZCo+SfsGZYK4wBMcWM6IotAQ0x5kFOuIC7J2qTWP/DZgw/89lq0o2?=
 =?us-ascii?Q?53+UOsGgI6xM3IG9Db8xc+I0LqFiUwdGE18JVMH/DIx6fSUyS5krBzbbKZyw?=
 =?us-ascii?Q?VVqZsZh9l+Ws17XC6a48YFHA0/JQtUKCCpU4TUI7R/gKTBcZciBME77HbXSJ?=
 =?us-ascii?Q?PpCX3sRT/nYvuRiGCpgXRo4mnfJViOG7qsB+8ZQsepcK6FG7u5gTcnzPyeVu?=
 =?us-ascii?Q?6oi71VFBEDQNyY5bg0X1OKE7JcaZQtYjGXkQRaQh6bh+g5cYmp9ykC1VjjU6?=
 =?us-ascii?Q?7FcfEy3qwaGDr3pHCSc3xzhsFSJiRcrehWb2kIJo4/VAP5KKigR6jNXr+uQh?=
 =?us-ascii?Q?XNdhZyJJgaZlUTuKJLB9r1n2rKbp38pHCR0OK0Mr7fmC0bJ2hv6GA3Ocv3F9?=
 =?us-ascii?Q?0gIKzn6mM140lc8LODSbGvjjMVUxhl+3i5uf3vrZPcV9AipF5MhE+Zh8XJ2J?=
 =?us-ascii?Q?LulJfslZ2ctRTf6dbbDs4UGwIBcJsIQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c424535c-5518-4f56-e3fd-08de648e7817
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 08:13:39.5902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXGiUDSI3GRwy/+jG84X4PVM40F8gFVmV7dqvcgeT8wPkm4mdIV/c7ghCu8alaC9Hc6EYasP4F2PLg+lxcTraonWsW02X2f4Mg2uDZuMANs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8699
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31578-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,lunn.ch:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C903BEFC3F
X-Rspamd-Action: no action



> -----Original Message-----
> From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Sent: Thursday, February 5, 2026 8:55 AM
> To: netdev@vger.kernel.org; linux-wireless@vger.kernel.org
> Cc: Johannes Berg <johannes@sipsolutions.net>; Ethan Nelson-Moore
> <enelsonmoore@gmail.com>; stable@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Stanislav Yakovlev <stas.yakovlev@gmail.com>;
> Alice Michael <alice.michael@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH net-next] net: intel: fix PCI device ID conflict
> between i40e and ipw2200
>=20
> The ID 8086:104f is matched by both i40e and ipw2200. The same device
> ID should not be in more than one driver, because in that case, which
> driver is used is unpredictable. Fix this by taking advantage of the
> fact that i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
> devices use PCI_CLASS_NETWORK_OTHER to differentiate the devices.
>=20
Commit message could be more detailed.
- Why the PCI ID is being reused (if known) Is this actually a reuse after =
EOL, or is there a misunderstanding? The commit message hand-waves this cri=
tical detail.
- Whether this is documented in hardware datasheets
- If there are bug reports of the conflict in the wild


> Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
If it's quite critical fix why not to send it to [PATCH net] ?=20


> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c  | 8 +++++++-
> drivers/net/wireless/intel/ipw2x00/ipw2200.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 0b1cc0481027..2c8f449ad659 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -75,7 +75,13 @@ static const struct pci_device_id i40e_pci_tbl[] =3D
> {
>  	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T4), 0},
>  	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_BC), 0},
>  	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_SFP), 0},
> -	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_B), 0},
> +	/*
> +	 * This ID conflicts with ipw2200, but the devices can be
> differentiated
> +	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and
> ipw2200
> +	 * devices use PCI_CLASS_NETWORK_OTHER.
> +	 */
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, I40E_DEV_ID_10G_B),
> +		PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, 0},
>  	{PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_X722), 0},
>  	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_X722), 0},
>  	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0}, diff --git
> a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> index 09035a77e775..b0e769da9415 100644
> --- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> +++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> @@ -11387,7 +11387,13 @@ static const struct pci_device_id card_ids[]
> =3D {
>  	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2754, 0, 0, 0},
>  	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2761, 0, 0, 0},
>  	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2762, 0, 0, 0},
> -	{PCI_VDEVICE(INTEL, 0x104f), 0},
> +	/*
> +	 * This ID conflicts with i40e, but the devices can be
> differentiated
> +	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and
> ipw2200
> +	 * devices use PCI_CLASS_NETWORK_OTHER.
> +	 */
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x104f),
> +		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, 0},
>  	{PCI_VDEVICE(INTEL, 0x4220), 0},	/* BG */
>  	{PCI_VDEVICE(INTEL, 0x4221), 0},	/* BG */
>  	{PCI_VDEVICE(INTEL, 0x4223), 0},	/* ABG */
> --
> 2.43.0


