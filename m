Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F47462E3F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 09:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbhK3INP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 03:13:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:31151 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239450AbhK3INO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 03:13:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="296971534"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="296971534"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 00:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="595259446"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2021 00:09:50 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 00:09:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 30 Nov 2021 00:09:50 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 30 Nov 2021 00:09:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOo7i+yqDIs4mKDd1b6B2+95OtJ5h92rjYgnj2SO0O0n5DwppbU4b88ZqJzyehcLA+tLt71R7kYhzlDsEqteCPmwGlqQ3GAi9CrLtbGKicAXWkBl2AYjL0jfPX+iyyvnvIcpeKeidiYvnjuxqcKaPjxwxnsxTbRrkqxZC4vruhUJuK0kZzSqooQFkgfc9PLtxfqRj8O0fc30FrePjOKJ5ELVq/+ll0qpON7gqTClK/Z0igvfcabISvHq9zPzDOKtWyobNcCTqScUm5ogqMqev+VTkffESVH5YBmVtGx1YZDZ8wMvvYm5SxNyTY+75uSLocQ5shul9DM2ycjnK/9y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3zHHQFohnoZMOarvUPqomNQXva43DfsV9mDGKMs3KI=;
 b=jzXglVsN+Sa7ByjSXpkMMLroYSvDLVgT9CvfHjz+JfQPDruFNoXkrqKhMUM9X+FRl4yvXYUURSLF5T8jo9NOhstfwf51HQgnaLEFIS2jG+tNYXG1o5pQC7ca2wJhKdAYi+5dtGRB3eT3cAlsfzXCab9hAZsq040DluZsdSODZ02mpGNgEiOXaUMnprAJfkv2+1FnFGzlPI8rrEEqTGD68yimlg8E7YicipxNPcYyswY5wYfFdKfEA6/+FNmV9SnA/WpYvWJ5NGbv2FwFNGlgrEZ4wLDgn0lPKiCqPg1jL6pjbsSm4xTitizOt+lUR2SpgFzJXh2tsnM9DsaR0RW/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3zHHQFohnoZMOarvUPqomNQXva43DfsV9mDGKMs3KI=;
 b=zIN8v/t/+hzv9S1ycEpxpBJPL8ZFZnSbr3DtUgRT0wtiflFUw4ETOmGnGK0QL6GUUCZwiy4nMV5Gvd5GTIQL6QENV0iULs5mnMWEvcHkjYrL+0hu246kCpoIBtB2teDp/CuMG27QzNIHHmg47TlNIesuuXA8weabSt6oiDZUXX4=
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SN6PR11MB2702.namprd11.prod.outlook.com (2603:10b6:805:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 08:09:48 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::787a:2f03:efff:c273]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::e814:a13b:4bbf:ef2%9]) with mapi id 15.20.4669.016; Tue, 30 Nov 2021
 08:09:48 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] iwlwifi: integrate with iwlmei
Thread-Topic: [bug report] iwlwifi: integrate with iwlmei
Thread-Index: AQHX5bJnE6C5zLTOiU668HAEMnQJR6wbt1OA
Date:   Tue, 30 Nov 2021 08:09:48 +0000
Message-ID: <SA1PR11MB58251D5736428C2C0FE235E4F2679@SA1PR11MB5825.namprd11.prod.outlook.com>
References: <20211130062017.GA20271@kili>
In-Reply-To: <20211130062017.GA20271@kili>
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
x-ms-office365-filtering-correlation-id: 04ff48fc-a165-4772-e54f-08d9b3d8c71b
x-ms-traffictypediagnostic: SN6PR11MB2702:
x-microsoft-antispam-prvs: <SN6PR11MB2702CEF512BD17E07F4BE491F2679@SN6PR11MB2702.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: psWml7zvRYSy9nW261XtZZKRO0dO6THggqCqb8iydsdwb77Ncx5Egxg8dkj8QQYFmbgOaBpgVrdTcgeUfEZ3nZYdNmeilcgTtwenTVY6vgUtgyroHnONAJjncWYJbHLGbRDr5Utn+PkVXVZRTMsSGuYm6EazJRierUueNx4vqIlD+6s5yoBlTMyc0yDdLpNMKcUZE9Mrck0C2b3qh/F7w/bZavx9c0e//T9siB+TUTIoEiCEjJSKVsLE3+YQu4x9X/lXkRM0t4mFusYAic/sGJ3Cqo+HTBFChNv+IwHv7rE5RP1BKzwcxGDa7lTC++39SNA27mT3t7L0Xahr+Oo44QeAnGAw0a+hGVmsxlp3YVFiGOjqQ5YU3i49vP1R8wwl61uMP4eiH3p8cdppMgoalNdsxhGDs4YUPzOnnV37Y/frxUKD14ChlTYrWlrvvhfY1r+/RgRIcOddgxqV5yagGvv1fbspBG8jS4dZTmnIZhwb//gVqenUPIxkc22bIz0bRztGNplD84fKqpFZL5c8w0pL1XQ73M3TQNWT1iHo+VmOv8XceS8gJXLZ2zEbHD38Djgx9tcjL/D+ZMv21MnbMgwmSLvZo9XmKk4pLonbsqqI+latNvURd/MuOLjLg8ifNacVN3zaiueodJBUCaI+kCW95LBK+0hn9rHKnRh8BaVbOsN7+FVF9x9NCf8H3qiIw+vUKKJ/aPtnm5G7s8FBUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(186003)(38070700005)(316002)(82960400001)(52536014)(122000001)(83380400001)(4326008)(86362001)(508600001)(9686003)(66946007)(33656002)(66476007)(76116006)(6916009)(5660300002)(71200400001)(8676002)(7696005)(8936002)(6506007)(2906002)(26005)(64756008)(66556008)(55016003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AjZl/ovZkfZJDiA/xpWtva6d82G8nZE1r5xPvCRbaeUaWYdWjMoIkoXsAAa9?=
 =?us-ascii?Q?PtJYOYzxnQ+qt7YLhmWTq5K+4kzAhx+q54uydpycM5ukgW3vvbc7EYyXue8u?=
 =?us-ascii?Q?8Z+ZgW26Ee+Igb0iwaEIELlHhTfTJv/f1+GMSkWdpeiEZsy7gtPfSyH8Y82d?=
 =?us-ascii?Q?wnuN1XLJJTQHxKooZcnY8bQaCBvhBAJydPCNXlE5Aqy0U4rPl1LxGS8F0kR+?=
 =?us-ascii?Q?ZYj9itJBlb3rJpJOsDOwQnvSPnSF25+YzwAJyPzlCmi2qywhEOmyZ5K8wcCf?=
 =?us-ascii?Q?rIrWSNO+cM87taUJtmx3UpzgMYfCloLPq9rVsdHcw8ZURcfIBWE9DGVjeRAQ?=
 =?us-ascii?Q?G4VJRnWb3sKw77clc676JRUdfp3wmYrUzqVCvdf0nS9bJmuaMNyQMU1R2HlZ?=
 =?us-ascii?Q?QRS/9Y8jVYYGGNxsREhfmx4roDwT31Of8m/akxW9OHSMSiRizy1tpv1G+hm9?=
 =?us-ascii?Q?18tpf+mpaIjK0EM9d51pZvGRSECGE7A/osS1R2j6tfeWfRdNR4YCArNbrPik?=
 =?us-ascii?Q?W6cvwEG1APfAks4577C8pQC28P8upjLXau87uYsZFWJ//Ei66FUxhnIWsVvZ?=
 =?us-ascii?Q?7oSAvvLlfHPIDEdLfbU2p3dhX6BtwhKhnkRohz2uuKS3pVc8bdLfZS8YrFTu?=
 =?us-ascii?Q?+AvagSuaEQNOfWteTX7VKoIySvEC+wikstGVRFKBlC7i+s3qL2UeOfU+nrjX?=
 =?us-ascii?Q?04I0JIk8PbmbkXAt5wq2gX4PDs6nBB/Azs2WOMuNOb+Eau4+/mVhM/ZsiuyT?=
 =?us-ascii?Q?iiKRKX24CPfWJplgtlJdBMbXNC7QW1//tS0yqpH10Z8R6pc+GwAYxG/Ri3j8?=
 =?us-ascii?Q?YGcapAspz5nfgHCFJea5SZUJGgj6hl0qCP1P2FxeaN8bFADfNjA6ZWOhRrfD?=
 =?us-ascii?Q?bSM8q0vM1fr8SJzrz9daLcbVeChGJF6RN3UU3P5179stZcvtd0YDScL7zl95?=
 =?us-ascii?Q?Z46pNuqGDDz3319NErNBnIfQa3KkurAKjfytFNlRx9RqlOPeblpBzCjB/pYo?=
 =?us-ascii?Q?eoDU/DgbCiMMuV3VpN4riqjB8lJO39kC247s1X2JmHbNuBrLeDvK6t9bzjlh?=
 =?us-ascii?Q?094QVhSlAv8Cj0OOwTfBVgWIasbO1UpVIRUWCbPoNZ/flRDYQ+gLEx90TRhQ?=
 =?us-ascii?Q?P09PRVU2zb9h/6NtXoL+Hh/wdWty1vLTJo7Ev7j5YQZyRYa5CdK5QVNoHLkH?=
 =?us-ascii?Q?9XF12uH/OQAjy4VOD6Sf80xeKlQSApHLpxUDkzS8KirzSvCwojawR/E9FKOT?=
 =?us-ascii?Q?ueLlnY19eQSucIitgqsQMWKryK76QNGwtG8UY303CGPwrpFzJmPoiCFtAsbU?=
 =?us-ascii?Q?Ldt9BibLfZUXBMuwT4dYQ1Lmz5ZkWPxR6czvEvTpSrpa9BXw/5D127Yfaf9U?=
 =?us-ascii?Q?h/RzT72JNA2iY0S8lW8EeN3J7PwTzdDcp2sBvK3ZwGgMXcfpZeQhdk8kjG8s?=
 =?us-ascii?Q?QDzjdKB8gx8D2bUa5u/mpBinCzWv4f3WK+kbi/Q87j/MzTeu8KghMJKNxtNg?=
 =?us-ascii?Q?3GYNDjeE9uZddf0C5J2wrgLNwJEVKTsudYylvquR2SVUlE+PWM3J4x75pogT?=
 =?us-ascii?Q?Ou4byaLS7PFTY+0mZUTxZYVsz+TY61MIlgSC/z6S6XqfCq69htouTFSjmUdy?=
 =?us-ascii?Q?cmLcei1LyxVRFN1fWnXXpYKktrT2YB2G2ypIFgdv0Nq6+EWRXh6XisWpomVR?=
 =?us-ascii?Q?1lw/TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ff48fc-a165-4772-e54f-08d9b3d8c71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 08:09:48.3322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZ/jatP2+k1y+PMiiLvpCUmfuOAAmEHjydOnzij0JwempuhsopMXH824gF9skpghI+IaP1H6NNydFiTL8RDX3WTUmH3eFAHEqKSxDq52I5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2702
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

> Hello Emmanuel Grumbach,
>=20
> The patch 6d19a5eba5cd: "iwlwifi: integrate with iwlmei" from Nov 12, 202=
1,
> leads to the following Smatch static checker warning:
>=20
> 	drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:2640
> iwl_mvm_start_ap_ibss()
> 	error: NULL dereference inside function
> '__iwl_mvm_mac_set_key()'

Where in __iwl_mvm_mac_set_key() ?
This function should be able to cope with with a NULL sta I think.
I don't really see how this could be related to my patch since iwlmei is no=
t related to AP mode at all.

I also moved to that commit, but the line numbers don't match, so I am a bi=
t confused.

>=20
> drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
>     2559 static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
>     2560                                  struct ieee80211_vif *vif)
>     2561 {
>     2562         struct iwl_mvm *mvm =3D IWL_MAC80211_GET_MVM(hw);
>     2563         struct iwl_mvm_vif *mvmvif =3D iwl_mvm_vif_from_mac80211=
(vif);
>     2564         int ret, i;
>     2565
>     2566         mutex_lock(&mvm->mutex);
>     2567
>     2568         /* Send the beacon template */
>     2569         ret =3D iwl_mvm_mac_ctxt_beacon_changed(mvm, vif);
>     2570         if (ret)
>     2571                 goto out_unlock;
>     2572
>     2573         /*
>     2574          * Re-calculate the tsf id, as the leader-follower relat=
ions depend
> on
>     2575          * the beacon interval, which was not known when the AP
> interface
>     2576          * was added.
>     2577          */
>     2578         if (vif->type =3D=3D NL80211_IFTYPE_AP)
>     2579                 iwl_mvm_mac_ctxt_recalc_tsf_id(mvm, vif);
>     2580
>     2581         mvmvif->ap_assoc_sta_count =3D 0;
>     2582
>     2583         /* Add the mac context */
>     2584         ret =3D iwl_mvm_mac_ctxt_add(mvm, vif);
>     2585         if (ret)
>     2586                 goto out_unlock;
>     2587
>     2588         /* Perform the binding */
>     2589         ret =3D iwl_mvm_binding_add_vif(mvm, vif);
>     2590         if (ret)
>     2591                 goto out_remove;
>     2592
>     2593         /*
>     2594          * This is not very nice, but the simplest:
>     2595          * For older FWs adding the mcast sta before the bcast s=
tation
> may
>     2596          * cause assert 0x2b00.
>     2597          * This is fixed in later FW so make the order of remova=
l depend
> on
>     2598          * the TLV
>     2599          */
>     2600         if (fw_has_api(&mvm->fw->ucode_capa,
> IWL_UCODE_TLV_API_STA_TYPE)) {
>     2601                 ret =3D iwl_mvm_add_mcast_sta(mvm, vif);
>     2602                 if (ret)
>     2603                         goto out_unbind;
>     2604                 /*
>     2605                  * Send the bcast station. At this stage the TBT=
T and DTIM
> time
>     2606                  * events are added and applied to the scheduler
>     2607                  */
>     2608                 ret =3D iwl_mvm_send_add_bcast_sta(mvm, vif);
>     2609                 if (ret) {
>     2610                         iwl_mvm_rm_mcast_sta(mvm, vif);
>     2611                         goto out_unbind;
>     2612                 }
>     2613         } else {
>     2614                 /*
>     2615                  * Send the bcast station. At this stage the TBT=
T and DTIM
> time
>     2616                  * events are added and applied to the scheduler
>     2617                  */
>     2618                 ret =3D iwl_mvm_send_add_bcast_sta(mvm, vif);
>     2619                 if (ret)
>     2620                         goto out_unbind;
>     2621                 ret =3D iwl_mvm_add_mcast_sta(mvm, vif);
>     2622                 if (ret) {
>     2623                         iwl_mvm_send_rm_bcast_sta(mvm, vif);
>     2624                         goto out_unbind;
>     2625                 }
>     2626         }
>     2627
>     2628         /* must be set before quota calculations */
>     2629         mvmvif->ap_ibss_active =3D true;
>     2630
>     2631         /* send all the early keys to the device now */
>     2632         for (i =3D 0; i < ARRAY_SIZE(mvmvif->ap_early_keys); i++=
) {
>     2633                 struct ieee80211_key_conf *key =3D mvmvif->ap_ea=
rly_keys[i];
>     2634
>     2635                 if (!key)
>     2636                         continue;
>     2637
>     2638                 mvmvif->ap_early_keys[i] =3D NULL;
>     2639
> --> 2640                 ret =3D __iwl_mvm_mac_set_key(hw, SET_KEY, vif, =
NULL,
> key);
>                                                                        ^^=
^^ This passes a NULL "sta" and now it
> will always crash.  (Possibly it used to sometimes crash before your patc=
h but
> the static checker does not mind about that.  :P).

This existed long before my patch


>=20
>     2641                 if (ret)
>     2642                         goto out_quota_failed;
>     2643         }
>     2644
>     2645         if (vif->type =3D=3D NL80211_IFTYPE_AP && !vif->p2p) {
>     2646                 iwl_mvm_vif_set_low_latency(mvmvif, true,
>     2647                                             LOW_LATENCY_VIF_TYPE=
);
>     2648                 iwl_mvm_send_low_latency_cmd(mvm, true, mvmvif->=
id);
>     2649         }
>     2650
>     2651         /* power updated needs to be done before quotas */
>     2652         iwl_mvm_power_update_mac(mvm);
>     2653
>     2654         ret =3D iwl_mvm_update_quotas(mvm, false, NULL);
>     2655         if (ret)
>     2656                 goto out_quota_failed;
>     2657
>     2658         /* Need to update the P2P Device MAC (only GO, IBSS is s=
ingle
> vif) */
>     2659         if (vif->p2p && mvm->p2p_device_vif)
>     2660                 iwl_mvm_mac_ctxt_changed(mvm, mvm->p2p_device_vi=
f,
> false, NULL);
>     2661
>     2662         iwl_mvm_bt_coex_vif_change(mvm);
>     2663
>     2664         /* we don't support TDLS during DCM */
>     2665         if (iwl_mvm_phy_ctx_count(mvm) > 1)
>     2666                 iwl_mvm_teardown_tdls_peers(mvm);
>     2667
>     2668         iwl_mvm_ftm_restart_responder(mvm, vif);
>     2669
>     2670         goto out_unlock;
>     2671
>     2672 out_quota_failed:
>     2673         iwl_mvm_power_update_mac(mvm);
>     2674         mvmvif->ap_ibss_active =3D false;
>     2675         iwl_mvm_send_rm_bcast_sta(mvm, vif);
>     2676         iwl_mvm_rm_mcast_sta(mvm, vif);
>     2677 out_unbind:
>     2678         iwl_mvm_binding_remove_vif(mvm, vif);
>     2679 out_remove:
>     2680         iwl_mvm_mac_ctxt_remove(mvm, vif);
>     2681 out_unlock:
>     2682         mutex_unlock(&mvm->mutex);
>     2683         return ret;
>     2684 }
>=20
> regards,
> dan carpenter
