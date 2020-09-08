Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAA26093C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 06:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgIHEPD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 00:15:03 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:38702
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgIHEPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 00:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599538500;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=A7GZ7UxfOSTDvmcpcQLWMuLOfXKeVQaj4LoAxBCj504=;
        b=EWg2B/7WQO2RB6YJ3gXLKyhPZdEluzKLnk8NSx+v7zh6w+Y6OOeJEhnXK8W3mhkl
        WBzlTW4DIca3bOjnuQWrwa0lv8ghKrDgabUIQrayuHMabuQZze3IbfzSNONhvAJRKsD
        aoekKnYttck1ihItVahyBuBouPodGFH8tNbSYP6E=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599538500;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=A7GZ7UxfOSTDvmcpcQLWMuLOfXKeVQaj4LoAxBCj504=;
        b=RFc+qIl2PqTGLDoG31wqTDuRnct6NX0vGsehq0ieyzuWS/LAEfROKBh/pPdPfBKZ
        TLeATzoVG+7QUm5cFPKymYEiX6WXoOyMiRa2I8nTuH2tt/XHoURBVL2DYYjHqbhkYVr
        FtQGeZWBBdVgCz7BOYeMKyxOpOQmEkHuXj6r3EXk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 8 Sep 2020 04:15:00 +0000
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5] ath10k: add atomic protection for device recovery
In-Reply-To: <1597984288-4141-1-git-send-email-wgong@codeaurora.org>
References: <1597984288-4141-1-git-send-email-wgong@codeaurora.org>
Message-ID: <010101746bec9197-04ef36e1-87a5-4b4c-b397-0fb4917d36dd-000000@us-west-2.amazonses.com>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.08-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-21 12:31, Wen Gong wrote:
v6 sent.
https://patchwork.kernel.org/patch/11762445/
[v6] ath10k: add atomic protection for device recovery
