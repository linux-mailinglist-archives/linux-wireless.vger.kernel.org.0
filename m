Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD2B7AD8A8
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjIYNMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjIYNMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 09:12:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3995FFE
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/6kJsovocZNi04vvaSQAYvjqXnjlAilFbtb7EljgXbM=;
        t=1695647559; x=1696857159; b=OzKcnkudmDCJO7+Yg1tdZxqw9nDW5YGWqacisY4Y+kVQ7sa
        2GOAOEwfEE2/8edWaym1cvTb8V/T9AdQ/yak4vsVEpSU1+MGQOO7TP4L8uKezRTLNwxqWtsgqkEN3
        oFzCcj8HZ/qqHB6h9QMeuoa3gnaMR2zA6BA2Kh166csW4dbhfv7gSDwNJl9QB7vcXHSmLuA8ucgf4
        vJId6mYDLiFTpeQJTfHAGvkmAkf1f8kOhk5aofozMg+ctRlM4h86swYTkqy1067uDV6Ny8cZJ5Sbp
        E/i8ALjRJqpf4Wr+2OyWmn74PXCWF15bNfe5pgrDPDQKDcwb0/jr5iLNiRVUmZHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qklO8-003ckJ-1W;
        Mon, 25 Sep 2023 15:12:36 +0200
Message-ID: <aae994910abeeb7e445eb2731eeb7dac0b3e43cb.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: add support for AP
 channel switch with MLO
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 25 Sep 2023 15:12:35 +0200
In-Reply-To: <20230925115822.12131-2-quic_adisi@quicinc.com>
References: <20230925115822.12131-1-quic_adisi@quicinc.com>
         <20230925115822.12131-2-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-09-25 at 17:28 +0530, Aditya Kumar Singh wrote:
>=20
> -void ieee80211_csa_finish(struct ieee80211_vif *vif)
> +void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_i=
d)
>  {
>  	struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(vif);
>  	struct ieee80211_local *local =3D sdata->local;
> +	struct ieee80211_link_data *link_data;
> +
> +	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
> +		return;

>=3D.

You also have that in the other patch.

johannes
