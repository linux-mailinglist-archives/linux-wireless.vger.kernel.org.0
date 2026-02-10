Return-Path: <linux-wireless+bounces-31689-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCP3OkLaimnrOAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31689-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 08:12:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E5117B02
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 08:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58BFB302A187
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 07:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A80B32FA2B;
	Tue, 10 Feb 2026 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cH+pcFzh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83932F770;
	Tue, 10 Feb 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770707519; cv=fail; b=l7H8zurNtXu1ibalNR1Y8hggeok/RkH2UraUPV4O2eMp7BnMdVkjEPZalB0ORsRdVKGN+kdd+puoexnWtsN6uU4NgV3vrb1LQTSVqigTUkAgJZGpAaQ61/W3jRWKkjLgU9TZf7cHvyh7YBSixudtG/yKhRkTdiFHCjKSuE2b0Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770707519; c=relaxed/simple;
	bh=4J+KrXL4BjLzviczSZOB16zKYoME+NKQ2xDZeL8Y2Yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgayNUDkIyDCnIHaPK8sFECpUUWsNCrn1WTPOYvOvLPm+zH5dQj+j1ge129cdQKKQekqF3Ip4aQJ7lq03ElSo+8gPCEfTL3Df4siRJMkahOz5xFEFD0KxNbUVW+c/8Y5LH11Iy5czLlUpYKZmhD209XGBk3LaC04yNY8lAy5Ri4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cH+pcFzh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770707518; x=1802243518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4J+KrXL4BjLzviczSZOB16zKYoME+NKQ2xDZeL8Y2Yk=;
  b=cH+pcFzhD41ULR+PMP9McGu6LULHm6V1D8KZnlCNQNblkGWVR9b66+8N
   Encozx0vQiKhHJrcWvaB6ptv2yObx/BSg+x7RKV6h2z4KgIhg8fbw7UdY
   2uIb+78jyAOcRxG/Ho4FpJTxL6dpRZlBhlP7oS+7WTb+A9QBM15RuHA+v
   hR+s8WjZm3pCIa5MwHzOjPeQCEv+3VZcl4ugjVAJMvholeMhD0iiD3rh5
   pcnzA6t+2j+ZBAFT7QribVUeJJoepbhHZmBAXrexOb/WGc42lIQSxU9D+
   QxRESNKtf6/qVPqTZ+AUez+W90U1AtdCsXNE6DatVbWOSlfRmk+KdOGXy
   g==;
X-CSE-ConnectionGUID: NOJSmHUaQHezXymWTCY3Fw==
X-CSE-MsgGUID: 5REwH8TeSQ21Tkc69uXDHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89413331"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89413331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:11:57 -0800
X-CSE-ConnectionGUID: Ngst/c02SimNwh3j31cEdQ==
X-CSE-MsgGUID: pPzZX0ggTvOsrhLx8Xi66w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="234788857"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:11:57 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 23:11:56 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 23:11:56 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 23:11:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUyiM1U+fErYKCVmqflhT8vAZKA9UR+7LCHdPVxp9adPE68VqgMo70YA+r7vZbFVjFB8p32TQqJHyibHtJu/ODRESynoidv/DimBvPcHG/hvyqfcNuzreDqWXXQlSIaFaY4NOv0wWQ+dxGLpD9GeeofqQhzp6k24ZSzvfnvxKmsgvbncMSmLDo1+i0yezEb7YHEsHNhGBONSah+UgVjVbpnWPuZaF876gq7Fg4lEXQhvLw2Qf1zuy/PijRfl6jg70EuRl/d4lc0dsTDCLEpQbXKSzHB/R4IAOWjlDeeVp9B7q4IcerIHGHU8HTLBiOHMeM77uumwnEB37RmMoqyRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX2Y5U3og24JZNf1HeGU7gp8zfcJAstV0Tx9JCSmyX0=;
 b=YSHEJ+FCwa6y8J+l2WiW6JwtpIu4uLjryZYcBtwQTRgP/ziGTR328xv63NaoqjUm1mjxZQRDr+Zpr6ded5s4dVJrllYj21xaT5uEX4QPCqTC1k+rFLkPcjls4nddTY6nOx9IX0AdYfwwzNQ4+3hXralKkIPMiXKtcIEI1J8GL/oiVjL+8LD5LeN5XDTC3yWKQSjO2z2tdeXkNdkPrxdprK38qXyuUHivOKYkxT9TAH4PTo348dFk9qCgbuC2EcLAcx86jpoIvA4nEMtEEVzzCWlexgOhh2YCuZv9dCF7MppIUSjVujOVbSqNhrqW6dpG8KqGTVrPNHgvFnFd2RuGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB9471.namprd11.prod.outlook.com (2603:10b6:208:5b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 07:11:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 07:11:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Stanislav
 Yakovlev" <stas.yakovlev@gmail.com>, Alice Michael <alice.michael@intel.com>
Subject: RE: [PATCH v2] net: intel: fix PCI device ID conflict between i40e
 and ipw2200
Thread-Topic: [PATCH v2] net: intel: fix PCI device ID conflict between i40e
 and ipw2200
Thread-Index: AQHcmjLR5ibK57mk202iuLeGL8WGwbV7hJdA
Date: Tue, 10 Feb 2026 07:11:54 +0000
Message-ID: <IA3PR11MB89865E1E74976F87328ACD4CE562A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260210021235.16315-1-enelsonmoore@gmail.com>
In-Reply-To: <20260210021235.16315-1-enelsonmoore@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB9471:EE_
x-ms-office365-filtering-correlation-id: ba2571fa-a0b6-46b4-27b3-08de6873ab98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?kGfL2Lli73f5wndDm9QE43vQTz5J+mZ2QWJ0A/gq82Q6Nc8y1m6xFcjQZSXn?=
 =?us-ascii?Q?YS38nNXyfkTe9SEK7cSV9oD7UXUaPh6unMdTdc8wUSscO7ylakvXb0fqE416?=
 =?us-ascii?Q?OYbVi7+gu9icothK3qk8bQxtCN7YLkwjHdaTti2KARW886Qf0Is8pQRT45Vo?=
 =?us-ascii?Q?+1apj/UEoaGVbLyYhSh+UtEvRot0DnNxaqc4U/6EDfLwTPAEhgV0Yl2PW/Nu?=
 =?us-ascii?Q?KybQ3DZnBxja17cTD8b3NrB/eAiv12vUaad780qd7ukcYKBTEYzXU6fcK7uO?=
 =?us-ascii?Q?GjtUetMj5+mxLMYjF/qncHh4G/9L1aN6dmWuCtkHQiqRbmbjssEn3HwKDhOK?=
 =?us-ascii?Q?lULvaw2M93IQXCiqLpkE81I0ov2MbtyUfs9T8qCw1h36bfWBVib6xrsZMVhT?=
 =?us-ascii?Q?FIpbmQ/fZOOjELlRb4WHvv1dbcV4egUKEWLJIkFoIFfeYM/LeQ7oKJ7WLRd4?=
 =?us-ascii?Q?QayqxE9yX+VmUSwlisLCXwhbCbyC0X+DHM3VJT2hFwQCCyZlKvVag6b+C/8v?=
 =?us-ascii?Q?VoAN1Ag5HNqokDMAWnFoIcjm0zMJ1cbVwFL1FXkEym2+bQYaP+lYAc05MkzN?=
 =?us-ascii?Q?yMjJc4J9iU89zULVQIon7kQ3lCTatX1XTUzZH/qvw4wWBdRrfdDe+tSLffQC?=
 =?us-ascii?Q?YHdsoKG5OhZfUkfUbJWNXFCdg/NU/C5lbLorcEfUmY+flPQW0PcFFj1I+5wq?=
 =?us-ascii?Q?/sgc1Vp+nn1TsmFuK9S2YNY6SxGMKjbJOMHMwhUv6vGr8JnhgWeCKy4yHOs3?=
 =?us-ascii?Q?TqcN2N9M2FogU8wnnH6wCYngS94AJOOwHN/1X56YRKb98fOGTmC+eIh/9RFt?=
 =?us-ascii?Q?v+m7dVgQ1s+Hr2EC/ZH5QIdQ/Mp0BzQMiF9by0kmpW9z5kTGfHY06asm/Alm?=
 =?us-ascii?Q?tfRoqR56VRK85EJ8CoQYqW3zXp7q4dhKR9kHbM9Q3mWJZDBammFEqL/4BQYY?=
 =?us-ascii?Q?w95RdEhTiSzowgcPxu3Gjb54e4ggHuHJTNm+17mnhD06Eorsskc2nXLQesQC?=
 =?us-ascii?Q?quV9u9D+hUAS3NxXvZZaaE8QMtipRC5oufWc0t4GiIVzC2kL+LdAsv3UqEzV?=
 =?us-ascii?Q?zH+GdUH/Nqw+lhXPgcKrHDQ54ZxHhC6KClWqN7Qlm5hjjfN/QdPLl62j5Vas?=
 =?us-ascii?Q?YIDS7hPtiDRgemSXfqR8YL0RdkFKwSL+SxANLawsvydMIej9/PGivlH+jl7Y?=
 =?us-ascii?Q?JhO234ThCFuXP1wQiNoWWIeD8Cndh2itd0DJmq005qTHR3dg7naHpmoffWRb?=
 =?us-ascii?Q?6qb4VJ5Xbl00kb4KqD3KsKDWC5E4t1kEjcMgQSbci5OuUmi6oYRVXSDg8XSf?=
 =?us-ascii?Q?TPybkpUXWVJBia5GcpHVllsZh8SgNOMhxMQEGEYyVP4O5PBgSzR8VdV1PhCS?=
 =?us-ascii?Q?U8HUgur4RYbxlrqV2/UTeKOU/A7aXxzXqAZrfyWUdGARa4xuMcSc7+4AdlsW?=
 =?us-ascii?Q?/QI3PMr/HtOA+roRmdG+0sXDDfxRan0Sv2hd+FKhcLSox3Ac4g7PZgNb3gZF?=
 =?us-ascii?Q?RF39zKcNzQ9zKLDNFzuIDTIxbT3fvctmOwd4dQw7eot/Z6ODvE0WDEfIbYzC?=
 =?us-ascii?Q?g7PpIBF6er06on3/sOpR7zIwVA11c27BTcJ7pmFERm8HtVHn0+3akHcVMG8+?=
 =?us-ascii?Q?jsLv7GX+zzv0M3DiNu/nnvI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KIDkAwZOiVsmmNe78IwMcXTZaEbArSNK6D01u5q3yg7VwpLTWFyM0Hkw1jvo?=
 =?us-ascii?Q?gYypzR8A6KUP2K6gnvgll4ozt07YhN2Bfr3EEZcnc3X06zRfDESTSrXgqdS7?=
 =?us-ascii?Q?/uj5EIgu5jL3v/cpbkmSnyfRLvePymt05w8PHCvYVMwsXsmsfNlvAzLKD3K9?=
 =?us-ascii?Q?5NBXoGQEdmT2yXBKKUT7oUtMEOyDI1crmDgoDhSffodisnPyCPwPHRxJ6FHQ?=
 =?us-ascii?Q?9MOMue4RcNeQIPJvsPYHCgylqCnM1yGYiu/PAk+bA2vn+CP84xUrMhv/BD+s?=
 =?us-ascii?Q?FFM3p28/3sIPi19nOr6HxYGNySVf3YXrUefVnXm992t9XxE7z3G4i3bKaNNc?=
 =?us-ascii?Q?JpNHcj0eg1IMYP9rJHS42eCyenzk52G4/Wu4+GmAmcRMJofl9h+t0vclXX0Q?=
 =?us-ascii?Q?T5vQjs4jFTDpu5tC5hiHryoL0OxnBR9ftklkZeupfAdd95VGt+Hir+7Aq///?=
 =?us-ascii?Q?fFXrIsEDhGc5PmtvaU6V+fs4nsLezDpeaqml0kroDZC23V7/dZPsESkCA+Rd?=
 =?us-ascii?Q?zvgI2izeToyHwZVbsH+k2YXonpF5GMHrSr+TL6TEwJWNCyVLlQOyiSP58pAJ?=
 =?us-ascii?Q?oAT8CV8Sz1y31WkGwQCSIWo7BpnycZ71G98Hg1QstN6NlrzAZmt/xwfVasRA?=
 =?us-ascii?Q?O02RauV3XMZTrani7EOC9HJblsq1phaz4Bb8yMWYI0zQlshfqnCh7o7a+ZB5?=
 =?us-ascii?Q?cqP+3lmkUYh0Xa4uxwgKNzTVEPG2LrYhdHZNIoYzIkfEzMEuAFI+d218cCGN?=
 =?us-ascii?Q?CheCVFgM4e/AGTkA+YBULKk5SOwf4H8zjkjOKqaqWfPZtTOQo4kOGHs3WUPA?=
 =?us-ascii?Q?Pj64N2iBOz7LvWFfd6MfMhfwBMzCKhC00Mxynl6cW8E8ACDGCMw3Hhq817TU?=
 =?us-ascii?Q?P1spNvdr3copfDNkOqVc/mGPLdqn5sKdDmxGDi7/6PiRQrEnorKBrtacJwrN?=
 =?us-ascii?Q?ogjPVUiqGcbzBcdKipVXp9Q47U6qzlLx9fuCf1fsQm6cKDlcoXN4wunac/ON?=
 =?us-ascii?Q?wOweOUpHn6EN7NiY9U2ofk613sa6AS0Rge37hnb7V9bi/COxQEg9qhFazM4r?=
 =?us-ascii?Q?0tuzevMQEqcJWUcMh/9fG/tLdJaqNOe9BEIF7zhExTRy+crWYp9iF8t1V4nc?=
 =?us-ascii?Q?55T2lAdshwT3DNrndKM3aA1CIq2gNSRWJXEJc2ffPkZ9r/yOD8eyZH+YHkTP?=
 =?us-ascii?Q?kOryjcGyUE8ZNtzuMKM4UAJfQXOKkOlZGVUHJaCjItZRJkrYyJdGiASAIkj9?=
 =?us-ascii?Q?SZ5wfvfF5p3r7Z6+2vTWHt3wvBpIVsAoT0qW3z1ka3oGr1wxENcg7zutPm8j?=
 =?us-ascii?Q?9IXg8+iw1TRZ/CLhGE8CehqJwokgzVSN4OnXg8OIm3E+tIMbnOrZBYrMzklZ?=
 =?us-ascii?Q?0OguYmi1D83YJqmrYRq1AffU7jGspQnx9sPn9QEkWQVuM1dgRrkq9ZyhAdZB?=
 =?us-ascii?Q?elR/KfoClpP3TApQIXP4Nd/u6qVZRfQq0KrpVZ1GJ69Ej7wiciFyeePkQtzb?=
 =?us-ascii?Q?iTSxeGsXYBwpszqVVhFoO9DA4O6s5sBvnUuUQ4RIhZoFb2rQg3YdapM5CCU5?=
 =?us-ascii?Q?APFgEXxb5Ih4HCPeYWw164XTzPrwX4oq0nqj76qYpgBVUCKdw+gkFy5cvXaj?=
 =?us-ascii?Q?kKyPV2EBALciwpxRZ4LdqRRWXDVWeAPIY82EhnuYbwJELFKWWc0JdW0zRwxi?=
 =?us-ascii?Q?RThyxzY374O+7KEBfaDiqSQC911u8lrDEL7rWBz8400DwdWZPj9PlfPVMpqY?=
 =?us-ascii?Q?CW23KiQ/bmqTcwBt0wddtA5lEJ0I5g4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2571fa-a0b6-46b4-27b3-08de6873ab98
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 07:11:54.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7Zgn4xyOLD6/vh3UpwdPrie3jS9fPs1R7pFWR2mYJDce5UZb2lBcDcwUx7UJTu8DG4qXcSvjhyVZSssp/xX2aWr940aD1+T0W9fxzp+yYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9471
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31689-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 670E5117B02
X-Rspamd-Action: no action



> -----Original Message-----
> From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Sent: Tuesday, February 10, 2026 3:13 AM
> To: netdev@vger.kernel.org; linux-wireless@vger.kernel.org
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>;
> stable@vger.kernel.org; Johannes Berg <johannes@sipsolutions.net>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Stanislav Yakovlev <stas.yakovlev@gmail.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Alice Michael
> <alice.michael@intel.com>
> Subject: [PATCH v2] net: intel: fix PCI device ID conflict between
> i40e and ipw2200
>=20
> The ID 8086:104f is matched by both i40e and ipw2200. The same device
> ID should not be in more than one driver, because in that case, which
> driver is used is unpredictable. Fix this by taking advantage of the
> fact that i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
> devices use PCI_CLASS_NETWORK_OTHER to differentiate the devices.
>=20
> Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
> Cc: stable@vger.kernel.org
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
> Changes from v1:
> Rebase on latest mainline instead of net-next
>=20
>  drivers/net/ethernet/intel/i40e/i40e_main.c  | 8 +++++++-
> drivers/net/wireless/intel/ipw2x00/ipw2200.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index d3bc3207054f..02de186dcc8f 100644
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

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


