Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27FF6D01A9
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjC3Ko7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 06:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjC3Ko3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 06:44:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FC286A9
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UBehT8pNiRhv/K+Pe28HQBR49fVVeAMH3P8J/KS4aE4=;
        t=1680173048; x=1681382648; b=aGTToQjbrcGhtr3bhWQQgvurZUu3rwwLYHunNvPCTV99+FC
        qfvPGe2rzkZgKSNW/VCUfTtygNv5SJmJHW+uTC/vOL9JlpdjjFbT2HXydDwxAZ9PprYtibmD06hUQ
        342+0B01WjowHKL/jawLwMm2l6++wSkIQ+kBqzJyqkPJJFqf2Z5mHf/Uh/vOsRikNJLLiUIxF7o0s
        GRS3O/Sb5qj7Xt/ANd119LnO97TZ7chHF2xkoXQIsjYlM9AU4PO/SyHjrqoCUq1L4dEMAqTCjVfhn
        xVj9qf63BWT6Xaj90GIeyYAHl59jo6VGISGtDMMNNY4AtZmgyGpgWlUB1Jd9Ce9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1phplF-000zbi-21;
        Thu, 30 Mar 2023 12:44:05 +0200
Message-ID: <d54800ae88be1eb232df7794e741dfc304c3ee9a.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: beacon EHT rate support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 30 Mar 2023 12:44:04 +0200
In-Reply-To: <20230329000902.17992-1-quic_alokad@quicinc.com>
References: <20230329000902.17992-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-03-28 at 17:09 -0700, Aloka Dixit wrote:

> +		switch (wdev->iftype) {
> +		case NL80211_IFTYPE_AP:
> +			width =3D wdev->u.ap.preset_chandef.width;

This seems a bit awkward and annoying, it means that we have to keep
using the API that sets the preset_chandef first, and it also means it
won't work for multi-link.

Couldn't you link it with the config in start_ap/join_mesh? And per-link
config in set_tx_bitrate_mask()?

Also not sure about this at all in parse_tid_conf()?

johannes

