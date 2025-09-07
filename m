Return-Path: <linux-wireless+bounces-27066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D236DB47BAE
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A917BD03
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7B3126C02;
	Sun,  7 Sep 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="OIXUIs/G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster6-host2-snip4-1.eps.apple.com [57.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4B29A2
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757252929; cv=none; b=BBxvU15liFqR+6peIoo2jmFRBVCT7K0Hxge6TO/Ge/jDHGmv7ppQbRw7i2wR3tV1ou4aVNWl06qowcyDW7CrPTszNywq3gbsydYKqYnkJbP0BZJJPMa9JWb7VBu42+MqThN1dZGte6j6CNbjYzSvlZmM0TWh4X4w0XV6l1yw9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757252929; c=relaxed/simple;
	bh=TXY82f44QKKwWZYS2/gphyFu8LxQOlLK8CEoh3JWbyA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=mDAZRm5rdVY3/4g5hTexg+vY2MKTgLNuV6VVtlO3KPP7+tTaxNZ8/tvYrUUBd38nIeAkOsH62NHDolIGiH2KH1klEwhVBpFZUs5CcbKMu+L2nzH/2MAnT2KATvGuGHy7iDoWQqWyEbAz8fzUtmHG42NXu53ar+tqfXzFhkaaTww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=OIXUIs/G; arc=none smtp.client-ip=57.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-0 (Postfix) with ESMTPS id D5AA41800199;
	Sun,  7 Sep 2025 13:48:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=TXY82f44QKKwWZYS2/gphyFu8LxQOlLK8CEoh3JWbyA=; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:x-icloud-hme; b=OIXUIs/GMAKUZHVklG7bvpf6vKcCRwzKKwD2Nj4eqnbAc6Ahhof60Ciu+olyJzO81KicypO7Fc3P6zE8xn/WrpD3S17OtOGfLJq7MfF1RQJhI6Uh8t8C7jUAvWLy0F5cbwb53XhrysbHluGORCqiw3Seanekim8chJyVLJIE3NJU8lXChbtKD+BlTsDpGbF8268n/L8Fp4tSJQE4TGxKr5/Teln71Sy0byGWjITnglGzEZhre8jBE5av3kFikdvsUAIXELyeGJPn2CSQFMlzDQ4JN4qX+SxoDjiWbu/ZpimA6hOA64wiq4Eodb2agCxcjeEbjadh1qP05DFsO5mpfQ==
Received: from [172.31.0.10] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-0 (Postfix) with ESMTPSA id 1E50A1800555;
	Sun,  7 Sep 2025 13:48:45 +0000 (UTC)
Message-ID: <1699b962-b9a1-4f94-b50a-8bfae4a156aa@icloud.com>
Date: Sun, 7 Sep 2025 06:48:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alex Gavin <a_gavin@icloud.com>
Subject: Re: Subject: [BUG] iwlwifi: Intel AX211 instability on TP-Link Deco
 Mesh, forced roaming/disconnects
To: Borhanudin Hamdan <borhanudin.hamdan@gmail.com>,
 linux-wireless@vger.kernel.org
References: <CAGpZD96962dro48k-rmTW1iBm+eF4zax6O0HS_HD+5+p6ptz1g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGpZD96962dro48k-rmTW1iBm+eF4zax6O0HS_HD+5+p6ptz1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kW2QNaWumJcJgolEVx8BJ-_9bUdzPnpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDE0MiBTYWx0ZWRfX3bZDvY8i8JhB
 mureWrHmEy99YdgB94zC1gdPHRPoDoXSo8jHwo871vw0iR3LMQ3zex+C8JCmDkvPCHAMJtdqMir
 HpKkasCPKLNAVA+Q873nM7YZzFKK4S7EJhDGtUaJCpwVYrMsFlfbo5ToTLYDiaOd37TgWYzos71
 G64oG8vhLOrZAlcaOWm4e6EusDWaPa2AuHv6uWOnKDlLb5t+vQyWQArE/1z59g5onT11XvTzwUR
 2yPLWjHPoqJTv8KF+xzZBn6hcKMNJmFemQM/H8ZWbkBpco21b1a/ho0DFY1Gz0m1rI/zUV2LU=
X-Proofpoint-ORIG-GUID: kW2QNaWumJcJgolEVx8BJ-_9bUdzPnpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509070142
X-JNJ: AAAAAAABD1JEfEBjwk0oBJZCjTRAQjgFo4WcdmcZbaiSeTE3rVfG3qpLs038mWKcwEZZXffcq7SNrSKurk2A6drdtqpnDzh3bSD/bwFEkGJAqKzo+fccTjcWlakDUtsKA1neEGk7yYC8wB/tmdl3lfMvcUfrhWFH1R79vcWGthN7leJra6nQktEJukpmRGDt+5ruGdO3MZmvInunRfQojaK5JGpJU8Qh1akKIikEIyt0Kq8/5YU/hkkeM0uR7PXfebnGG0+SS5cdqWWRcufFCvpGX0uIxtGXMxlTyfDZy9FJn2ZLOwrEgoz/nJ6S30OIZhxwGuYaB7cv/FEb4u7ryDT8KTKqWppfhxOuvRmfQXvfVliMS+m3wdNFvfZVqV8YbQOUc072aYyrDqatRIh7gS+DHRr3hB3cONr830uTZIxRdxB4EJCQDqr+MtzBZn2VmA36Nbk4novxi0r/iW1Ej84SI3Fa/jD7tF+f+fLbxpiAdrPPmoVID7px2WUF+0q9ynnGHl/+CvVDW+WbUobcBIwKqat1w5i+VURACLf4CjuUtzhNTaaq+TcoNoYzOQkub87G6YTltkxRP50aqlEhG0Gg/1UzAn4SWgTtHlO/aIE+Yezs7kshd3+za8NrB08dsRknu8jD14yM1efb6N35JBFqToOx1ddsM7lLY7hi3sdXsDxgFHwHruOa

On 9/7/25 05:45, Borhanudin Hamdan wrote:
> The following is a unified log captured during these events. It contains both the high-level |
> PING_MONITOR|(showing when internet access is lost) and the low-level kernel messages from |dmesg|
> (showing the hardware activity). You can see the clear correlation between the "CONNECTION LOST"
> events and the "deauthenticating by local choice" messages.

Are you able to share logs from 'wpa_supplicant' or 'iwd' as well? The logs here do show the station
deauthenticate from each BSS (rather than the AP deauthenticating the station, see 'by local choice'
in logs). However, the reason for this is unclear without more information from the station.

I see Ubuntu in your message, which by default uses 'wpa_supplicant' through 'NetworkManager'.
Assuming this is the case for your system, the following commands will gather logs from
'wpa_supplicant' for the current boot:

# Just supplicant
journalctl -b 0 -u wpa_supplicant.service

# Both supplicant and kernel logs
journalctl -b 0 -t wpa_supplicant -t kernel


For more verbose logs, you can edit the systemd service config file by adding '-d' or '-dd' to the
'ExecStart' directive as below. After editing, make sure to reload the service configuration
('systemctl daemon-reload') and restart the service (or just reboot).

# Add '-dd' to 'ExecStart' directive
ExecStart=/sbin/wpa_supplicant -dd -u -s -O /run/wpa_supplicant


