Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F9D7195BE
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 10:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjFAIhm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjFAIhQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 04:37:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666491727
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iiCEvE7WPvwLnzqEnubMTOItfRP7CMsDeGL5KZqBD30=;
        t=1685608555; x=1686818155; b=RSNqTe5hbQORxnB+9R4GIVlml1f/u5Fj/CkcFZIIE42MfrX
        tY45zlYDD5WJWQtGqA/trQx6LAsfBPVFRLrcOUQ9joCbXr/fPa9EmXAkAzrvf9pvskGTJyUEiMR++
        EP1vwe4/V+bCNWldRnceDk5MSwCwxCVGkghG9g+IL3r8bB7sPyw6KR/3dvgrfGO6a/KjwymWevDAV
        7qSVMd0exMegKiAS/uuHe/QAfxlDDXCZWjLLL/EiaJAgur/H4u2jZ8VB2VRkw1/U7Q8KEib/lAjK5
        rcfGhzcvOU4eI/UZT39IrgRCq054+b40PdQQHBlGaQ8Ys6XSSwAQKfjD0/5owA6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q4dmi-00ALAq-2S;
        Thu, 01 Jun 2023 10:35:52 +0200
Message-ID: <21f6e68474f248e3288ddb24696401ae0a3553e3.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi:  Add support for tx-override feature.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Thu, 01 Jun 2023 10:35:51 +0200
In-Reply-To: <20230531231214.2694997-1-greearb@candelatech.com>
References: <20230531231214.2694997-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>  	struct iwl_mvm_ethtool_stats ethtool_stats;
> +	struct iwl_txo_data txo_data;

Might be nicer to have this a pointer and be NULL if not active? that
way you can also use proper RCU protection for it when changing it.

johannes
