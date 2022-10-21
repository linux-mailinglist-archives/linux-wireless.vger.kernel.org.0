Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4416076DB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 14:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJUMZo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 08:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUMZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 08:25:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697691BC179
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jAzRSUGgENCNFLGU9uz9gZVi35DrYMgfiBGE0CplVIM=;
        t=1666355141; x=1667564741; b=EBHJV6e/w66qdc2LyXSoE+bT5b4qqh5cmFKJNnThHRN1q1h
        QrmsgxzvFmv2Tx/OzPR6csHnRSMIg2OWaE0yvREv1Sh37pmbvs3zLXMWyJNgeq6tuIa2U5G9u5QsV
        G269cY6x2kPKj4WBjCgQJoBcqwQDBLNTpL5AUw0dRPOdDnqHP0kjF3tyjtcUEsZ0xw0sS4eMtqG2p
        X5eVmJN5Wpx0eQF1H4LAiDOlbKfg/UEyvvgch9IEUW3Hi6YeoTIxMa9CkJ6gGQ/XhBbn79LgdBA30
        QK4FAwP6ZtqxBn4Vo4+Rkmyl3RBh8EP3rr8oBfEcDU5QC2CJZMLKzyUmwd6inmBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1olr5n-00CrAB-0v;
        Fri, 21 Oct 2022 14:25:39 +0200
Message-ID: <bd8d9fe60b4ff7a420ab597b1db64b5b42616d77.camel@sipsolutions.net>
Subject: Re: [RFC 4/4] wifi: nl80211: send iface combination to user space
 in multi-hardware wiphy
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 21 Oct 2022 14:25:38 +0200
In-Reply-To: <20220920100518.19705-5-quic_vthiagar@quicinc.com>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
         <20220920100518.19705-5-quic_vthiagar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-09-20 at 15:35 +0530, Vasanthakumar Thiagarajan wrote:
> A new nested nl attribute is added to the same existing NL command to
> advertise the iface combination capability for each underlying hardware
> when driver groups more than one physical hardware under one wiphy to
> enable MLO among them.

That's a good point - are we assuming this implies you can do MLO across
the groups? Maybe somebody would want to use this advertisement without
allowing MLO? (Not sure that's useful vs. multiple wiphys though, but
maybe to simplify driver if there are some devices w/o MLO?)

> +		for (l =3D 0; l < c->iface_hw_list->n_limits; l++) {
> +			struct nlattr *limit;
> +
> +			limit =3D nla_nest_start(msg, l + 1);
> +			if (!limit)
> +				return -ENOBUFS;
> +
> +			if (nla_put_u16(msg, NL80211_IFACE_LIMIT_MAX,
> +					c->iface_hw_list[i].limits[l].max))
> +				return -ENOBUFS;
> +
> +			if (nla_put_u16(msg, NL80211_IFACE_LIMIT_TYPES,
> +					c->iface_hw_list[i].limits[l].types))
> +				return -ENOBUFS;
> +
> +			nla_nest_end(msg, limit);
> +		}
> +		nla_nest_end(msg, limits);


Feels like this part is kind of pre-existing code, or should be, could
it be refactored?

> +		if (nla_put_u32(msg,
> +				NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
> +				c->iface_hw_list[i].num_different_channels))
> +			return -ENOBUFS;
> +
> +		if (nla_put_u16(msg,
> +				NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
> +				c->iface_hw_list[i].max_interfaces))
> +			return -ENOBUFS;
> +
> +		nla_nest_end(msg, hw_combi);

And even this feels like it must already exist in some way? Wouldn't it
even be easier to parse for userspace if it wasn't a separate set of
attributes?

johannes
