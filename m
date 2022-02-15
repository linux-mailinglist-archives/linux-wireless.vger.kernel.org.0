Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7003B4B6453
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 08:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiBOH2s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 02:28:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiBOH2q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 02:28:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A3F1AEF
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 23:28:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11142B817FA
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 07:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039C0C340F0;
        Tue, 15 Feb 2022 07:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644910114;
        bh=RTVvjz/1iCiphGZ0p/8x+4clbKPTZXr7PfwN7/acL40=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YJqsFeWYPPkWPMw+SSVYR2kX7ZBf/4cvXS4GhdicOP0NqImatm9iBJNxaO6O4mlPT
         PLdfXDWkhQgihCTbHm0MEOpObPwenjMBtkDj52/Remmo2k9hXsQrAceJvf4Jb7Bala
         4PFdPVonykDmRlS7qoQ5Ta9YS4Aa8BcWVd9+RAr/HPzZCbtwD7m/7SPZ+Wk0phIECP
         of4Yt6LYAZXU8eHgkfUNW7tz18A8qxBq8El96xg630SaEABjPsGEU37JGG7jVBo3II
         rVRqFdEnuPipJgMgluXdR6ARtKnXW2hVtUZI4Y/5Nk3Ngpsl2pjOhm26CnmAevJs4t
         ecjewuiPjX+0g==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Aloka Dixit \(QUIC\)" <quic_alokad@quicinc.com>
Cc:     'Johannes Berg' <johannes@sipsolutions.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Vikram Kandukuri \(QUIC\)" <quic_vikram@quicinc.com>,
        "Jia Ding \(QUIC\)" <quic_jiad@quicinc.com>,
        "Karthikeyan Periyasamy \(QUIC\)" <quic_periyasa@quicinc.com>,
        "Muna Sinada \(QUIC\)" <quic_msinada@quicinc.com>,
        "Sriram R \(QUIC\)" <quic_srirrama@quicinc.com>,
        "ilan.peer\@intel.com" <ilan.peer@intel.com>
Subject: Re: [PATCH v2 06/19] cfg80211: Add data structures to capture EHT capabilities
References: <20220210192008.188166-1-johannes@sipsolutions.net>
        <20220210201853.c40044dc90e9.I2413a37c8f7d2d6d638038a3d95360a3fce0114d@changeid>
        <DM8PR02MB7958C66988E52F40F0ED8A6AFE309@DM8PR02MB7958.namprd02.prod.outlook.com>
        <13d897bae6ac5bfd25c7b2e2c80fdaac392334ce.camel@sipsolutions.net>
        <DM8PR02MB7958BEAFECDCC17097F4A731FE339@DM8PR02MB7958.namprd02.prod.outlook.com>
Date:   Tue, 15 Feb 2022 09:28:27 +0200
In-Reply-To: <DM8PR02MB7958BEAFECDCC17097F4A731FE339@DM8PR02MB7958.namprd02.prod.outlook.com>
        (Aloka Dixit's message of "Mon, 14 Feb 2022 15:55:52 +0000")
Message-ID: <87wnhwa8ro.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Aloka Dixit (QUIC)" <quic_alokad@quicinc.com> writes:

> (something weird happened with your quoting?)
> Yeah =E2=98=B9 need to check.
>
> AP mode, especially non-mac80211, wasn't really high on our list ...
>
> I'm also not sure it really belongs to this patch, since this patch was
> just meant to capture the EHT capabilities of the device, not support AP
> mode :-)
>
> I think I'd prefer to have a separate patch, later, and we can discuss
> whether I should submit that or you want to (I cannot really test it).
> Any objections?
>
> Sure, that sounds good!
> Thanks.

Aloka, your quotes are still wrong. It's impossible to see which is
Johannes' text and which is yours.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
