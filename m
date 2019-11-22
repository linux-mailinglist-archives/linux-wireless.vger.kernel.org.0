Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E821076F8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 19:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKVSIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 13:08:52 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:49088 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfKVSIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 13:08:52 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iYDMQ-0003qm-NJ; Fri, 22 Nov 2019 19:08:50 +0100
Message-ID: <43f4d446d7f8b9a08e091ab811fbf99bf00da2af.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/3] fix a STA PS bug and add PS support to
 mac80211_hwsim
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 22 Nov 2019 19:08:49 +0100
In-Reply-To: <d943f37db7a57dbc335cacfa5cbbd38c8ae8dea9.camel@sipsolutions.net>
References: <20191119053538.25979-1-thomas@adapt-ip.com>
         <85ed0881d0aeecd886b27bd482fa61fa86d96729.camel@sipsolutions.net>
         <f0ae4c07-d3c3-768f-49c0-1f2a6c5a687d@adapt-ip.com>
         <d943f37db7a57dbc335cacfa5cbbd38c8ae8dea9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-22 at 19:04 +0100, Johannes Berg wrote:
> 
> Various. Jouni just said mostly concurrency ones, e.g.
> 
> p2p_cli_invite
> ap_cipher_tkip_countermeasures_ap_mixed_mode
> discovery_while_go_p2p_dev
> radius_macacl_unreachable

Ah, still had my list open:

discovery_while_go radius_macacl_unreachable
discovery_while_go_p2p_dev bgscan_learn_beacon_loss
wifi_display_parsing ap_vlan_iface_cleanup_multibss
ap_vlan_iface_cleanup_multibss_per_sta_vif
autogo_2cli
bgscan_simple_beacon_loss
rrm_lci_req_timeout
rrm_ftm_range_req_timeout
p2p_cli_invite

johannes

