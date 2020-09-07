Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF225F65B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 11:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgIGJVd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 05:21:33 -0400
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:49418
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbgIGJVd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 05:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599470492;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=9b5FrUg1iGXJA/9iw+ulM0boM5F0pty0Vwes5WHWREM=;
        b=OCJ15qBk+EpBxSJqVpPWgq45o+uyNuaamvCVL7tFGQhP/S792+K0TOgwHm45Cgw8
        6ooyhAtZi3F07r/Rzr868Sp5gKGlyFPSL7yoEL159A0zIckpRWRRkiFc+8oSFUpH+Ml
        qUAbS4dMhtiBsru1RiFOFaap6eQwKt+hybNVJJcE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599470492;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=9b5FrUg1iGXJA/9iw+ulM0boM5F0pty0Vwes5WHWREM=;
        b=N5JXDjpde/0IK319bY0jnbobJ8PLeXN+Vk5+VdpIpXu3UAIh4nEt1ZpR0lTBLAI5
        aQBrnIzdQXNoTfBPgkHtD+FErOZpEdKxZe5NF0ZKcbi6PcjitbzgISuzn43WJJ2MWmr
        2u+ctpPf/id8s+BW3yMDrNXk7Z+/e+H7qm612QRw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6D42C43463
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com, Ting-Ying Li <tingying.li@cypress.com>
Subject: Re: [PATCH 4/4] brcmfmac: add a variable for packet forwarding condition
References: <20200901063237.15549-1-wright.feng@cypress.com>
        <20200901063237.15549-5-wright.feng@cypress.com>
Date:   Mon, 7 Sep 2020 09:21:32 +0000
In-Reply-To: <20200901063237.15549-5-wright.feng@cypress.com> (Wright Feng's
        message of "Tue, 1 Sep 2020 01:32:37 -0500")
Message-ID: <0101017467dedc38-3e3a7b7e-3e16-4eb2-adcf-5b6f502178ac-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> writes:

> From: Ting-Ying Li <tingying.li@cypress.com>
>
> When the "ap_isolate" function is not set by the host,
> host-based packet forwarding will be enabled if the packet
> forwarding mechanism is not offloaded to the lower layer.
>
> Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>

[...]

> +	/* Get ap_isolate value from firmware to detemine whether fmac */
> +	/* driver supports packet forwarding. */
> +	if (brcmf_fil_iovar_int_get(ifp, "ap_isolate", &val) == 0) {
> +		ifp->fmac_pkt_fwd_en =
> +			((params->ap_isolate == 0) && (val == 1)) ?
> +			true : false;
> +	} else {
> +		brcmf_err("get ap_isolate iovar failed: ret=%d\n", ret);
> +		ifp->fmac_pkt_fwd_en = false;
> +	}

This is hard to read, you can simplify it to:

if (brcmf_fil_iovar_int_get(ifp, "ap_isolate", &val) == 0 &&
    params->ap_isolate == 0 &&
    val == 1) {
	ifp->fmac_pkt_fwd_en = true;
} else {
	brcmf_err("get ap_isolate iovar failed: ret=%d\n", ret);
	ifp->fmac_pkt_fwd_en = false;
}


-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
