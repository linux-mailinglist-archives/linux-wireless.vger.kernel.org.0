Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7361F762C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2020 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgFLJpW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jun 2020 05:45:22 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:48829 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgFLJpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jun 2020 05:45:21 -0400
Received: from [192.168.178.27] (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 29AAB580060;
        Fri, 12 Jun 2020 11:45:19 +0200 (CEST)
Subject: Re: [PATCH] mac80211: skip mpath lookup also for control port tx
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <20200611164410.606859-1-markus.theil@tu-ilmenau.de>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 HbCBIiM=
Message-ID: <cc0661d3-f0b2-3a82-27bd-91e3b2b8591d@tu-ilmenau.de>
Date:   Fri, 12 Jun 2020 11:45:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611164410.606859-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/11/20 6:44 PM, Markus Theil wrote:
> When using 802.1X over mesh networks, at first an ordinary
> mesh peering is established, then the 802.1X EAPOL dialog
> happens, afterwards an authenticated mesh peering exchange
> (AMPE) happens, finally the peering is complete and we can
> set the STA authorized flag.
>
> As 802.1X is an intermediate step here and key material is
> not yet exchanged for stations we have to skip mesh path lookup
> for these EAPOL frames. Otherwise the already configure mesh
> group encryption key would be used to send a mesh path request
> which no one can decipher, because we didn't already establish
> key material on both peers, like with SAE and directly using AMPE.
I found issues with the non nl80211 tx path. Please drop this version.
